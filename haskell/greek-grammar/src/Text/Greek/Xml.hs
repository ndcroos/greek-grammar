{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}

module Text.Greek.Xml where

import Prelude hiding ((*), (+))
import Conduit
import Control.Lens
import Data.Char
import Data.Text (Text)
import Text.Greek.Utility
import qualified Data.Conduit.Attoparsec as X
import qualified Data.Text as T
import qualified Data.XML.Types as X
import qualified Text.XML.Stream.Parse as X

xmlNamespace :: Text
xmlNamespace = "http://www.w3.org/XML/1998/namespace"

xmlNamespacePrefix :: Text
xmlNamespacePrefix = "xml"

newtype Line = Line { getLine :: Int } deriving (Eq, Ord, Show)
newtype Column = Column { getColumn :: Int } deriving (Eq, Ord, Show)
newtype Path = Path { getPath :: FilePath } deriving (Eq, Ord, Show)

readEventsConduit :: FilePath -> IO [Maybe X.PositionRange * X.Event]
readEventsConduit p = runResourceT $ sourceFile p =$= X.parseBytesPos X.def $$ sinkList

data XmlInternalError
  = XmlInternalErrorEmptyEvents
  | XmlInternalErrorExpectedBeginDocument (Maybe X.PositionRange, X.Event)
  | XmlInternalErrorExpectedEndDocument (Maybe X.PositionRange, X.Event)
  | XmlInternalErrorUnexpectedEmptyPositionRange (Maybe X.PositionRange, X.Event)
  deriving (Show)

data XmlError c
  = XmlErrorNonBasicEvent c X.Event
  | XmlErrorUnexpectedNamespace c X.Name
  deriving (Show)

data LineReference = LineReference
  { lineReferenceLine :: Line
  , lineReferenceColumn :: Column }
  deriving (Show)
data FileReference = FileReference
  { fileReferencePath :: Path
  , fileReferenceBegin :: LineReference
  , fileReferenceEnd :: LineReference }
  deriving (Show)

toFileReference :: FilePath -> X.PositionRange -> FileReference
toFileReference p (X.PositionRange (X.Position startLine startColumn) (X.Position endLine endColumn))
  = FileReference (Path p) (LineReference (Line startLine) (Column startColumn)) (LineReference (Line endLine) (Column endColumn))

tryDropBeginDocument :: [Maybe X.PositionRange * X.Event] -> [XmlInternalError] + [Maybe X.PositionRange * X.Event]
tryDropBeginDocument [] = Left [XmlInternalErrorEmptyEvents]
tryDropBeginDocument (x : xs) = case x of
  (_, X.EventBeginDocument) -> Right xs
  _ -> Left . pure $ XmlInternalErrorExpectedBeginDocument x

tryDropEndDocument :: [Maybe X.PositionRange * X.Event] -> [XmlInternalError] + [Maybe X.PositionRange * X.Event]
tryDropEndDocument [] = Left [XmlInternalErrorEmptyEvents]
tryDropEndDocument (x : xs) = case x of
  (_, X.EventEndDocument) -> Right xs
  _ -> Left . pure $ XmlInternalErrorExpectedEndDocument x

tryConvertPosition :: FilePath -> Maybe X.PositionRange * X.Event -> XmlInternalError + (FileReference * X.Event)
tryConvertPosition p (Just r, e) = Right (toFileReference p r, e)
tryConvertPosition _ x = Left $ XmlInternalErrorUnexpectedEmptyPositionRange x

tryConvertPositions :: FilePath -> [Maybe X.PositionRange * X.Event] -> [XmlInternalError] + [FileReference * X.Event]
tryConvertPositions p = splitMap (tryConvertPosition p)

dropComment :: (FileReference * X.Event) -> [FileReference * X.Event] -> [FileReference * X.Event]
dropComment (_, X.EventComment _) xs = xs
dropComment x xs = x : xs

dropComments :: [FileReference * X.Event] -> [FileReference * X.Event]
dropComments = foldr dropComment []

type XmlAttributes = [X.Name * [X.Content]]
type BasicEvent e c a = BasicEventFull e e c a
data BasicEventFull be ee c a
  = BasicEventBeginElement be a
  | BasicEventEndElement ee
  | BasicEventContent c
  deriving (Show)
makePrisms ''BasicEventFull

toBasicEvent :: X.Event -> X.Event + BasicEvent X.Name X.Content XmlAttributes
toBasicEvent (X.EventBeginElement n as) = Right (BasicEventBeginElement n as)
toBasicEvent (X.EventEndElement n) = Right (BasicEventEndElement n)
toBasicEvent (X.EventContent c) = Right (BasicEventContent c)
toBasicEvent x = Left x

toBasicEvents :: [c * X.Event] -> [XmlError c] + [c * BasicEvent X.Name X.Content XmlAttributes]
toBasicEvents = splitMap (tryOver _2 toBasicEvent (errorContext XmlErrorNonBasicEvent _1))

readEvents :: FilePath -> IO ([XmlInternalError] + [FileReference * X.Event])
readEvents p = fmap (initialTransform p) . readEventsConduit $ p

initialTransform :: FilePath -> [Maybe X.PositionRange * X.Event] -> [XmlInternalError] + [FileReference * X.Event]
initialTransform p x = return x
  >>= tryDropBeginDocument
  >>. reverse
  >>= tryDropEndDocument
  >>. reverse
  >>= tryConvertPositions p

trimContent :: Getter s X.Event -> [s] -> [s]
trimContent g = foldr (trimContentItem g) []

trimContentItem :: Getter s X.Event -> s -> [s] -> [s]
trimContentItem g x xs
  | x1 : x2 : xs' <- xs
  , X.EventBeginElement _ _ <- view g x
  , X.EventContent (X.ContentText t) <- view g x1
  , X.EventBeginElement _ _ <- view g x2
  , T.all isSpace t
  = x : x2 : xs'

  | x1 : x2 : xs' <- xs
  , X.EventEndElement _ <- view g x
  , X.EventContent (X.ContentText t) <- view g x1
  , X.EventEndElement _ <- view g x2
  , T.all isSpace t
  = x : x2 : xs'

  | x1 : x2 : xs' <- xs
  , X.EventEndElement _ <- view g x
  , X.EventContent (X.ContentText t) <- view g x1
  , X.EventBeginElement _ _ <- view g x2
  , T.all isSpace t
  = x : x2 : xs'

  | otherwise
  = x : xs

newtype XmlLocalName = XmlLocalName Text deriving (Eq, Ord, Show)

tryDropNamespace :: X.Name -> X.Name + XmlLocalName
tryDropNamespace (X.Name n Nothing Nothing) = Right $ XmlLocalName n
tryDropNamespace n = Left $ n