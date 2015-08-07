{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Text.Greek.Source.Sblgnt where

import Prelude hiding ((*), (+), log, FilePath)
import Control.Lens
import Data.Text (Text)
import Text.Greek.Utility
import Text.Greek.Xml
import qualified Prelude as X (FilePath)

type FinalEvent
  = EventBeginElement * Text * XmlAttributes
  + EventEndElement * Text
  + EventContent * XmlContent

readSblgntEvents :: X.FilePath -> IO ([ErrorMessage] + [FileReference * FinalEvent])
readSblgntEvents = fmap (>>= tx) . readEvents

tx :: [FileReference * EventAll]
   -> [ErrorMessage] + [FileReference * FinalEvent]
tx x = return x
  >>= tx11
  >>= tx12
  >>= tx13
  >>= tx14
  >>= tx15
  >>= tx16
  >>= tx17
  >>. tx17a
  >>= tx18
  >>= tx19
  >>. tx19a

type EventSimple
  = EventBeginElement * XmlName * XmlAttributes
  + EventEndElement * XmlName
  + EventContent * XmlContent

tx11 :: Handler e (a * (EventBeginDoctype * Text * (Maybe XmlExternalId) + b)) =>          
                  [a * (EventBeginDoctype * Text * (Maybe XmlExternalId) + b)]
    -> [e] +      [a * (                                                   b)]
tx11 = handleMap _2 tryDrop1

tx12 :: Handler e (a * (EventEndDoctype + b)) =>
                  [a * (EventEndDoctype + b)]
    -> [e] +      [a * (                  b)]
tx12 = handleMap _2 tryDrop1

tx13 :: Handler e (a * (EventInstruction * XmlInstruction + b)) =>
                  [a * (EventInstruction * XmlInstruction + b)]
    -> [e] +      [a * (                                    b)]
tx13 = handleMap _2 tryDrop1

tx14 :: Handler e (a * (b1 + b2 + b3 + EventComment * Text + c)) =>
                  [a * (b1 + b2 + b3 + EventComment * Text + c)]
    -> [e] +      [a * (b1 + b2 + b3 +                       c)]
tx14 = handleMap _2 tryDrop4

tx15 :: Handler e (a * (b1 + b2 + b3 + EventCDATA * Text)) =>
                  [a * (b1 + b2 + b3 + EventCDATA * Text)]
    -> [e] +      [a * (b1 + b2 + b3                    )]
tx15 = handleMap _2 tryDrop4e

tx16 :: Handler e (a * (b1 * (b1a * b1b * b1c * Maybe Text) * y + b2)) =>
                  [a * (b1 * (b1a * b1b * b1c * Maybe Text) * y + b2)]
    -> [e] +      [a * (b1 * (b1a * b1b * b1c            ) * y + b2)]
tx16 = handleMap (_2 . _Left . _2 . _1 . _2 . _2) tryDrop2Nothing

tx17 :: Handler e (a * (b1 * (b1a * b1b * Maybe Text) * y + b2)) =>
                  [a * (b1 * (b1a * b1b * Maybe Text) * y + b2)]
    -> [e] +      [a * (b1 * (b1a * b1b            ) * y + b2)]
tx17 = handleMap (_2 . _Left . _2 . _1 . _2) tryDrop2Nothing

tx17a :: [a * (b1 * (XmlNameId * b1b) * y + b2)]
      -> [a * (b1 * (            b1b) * y + b2)]
tx17a = over (each . _2 . _Left . _2 . _1) snd

tx18 :: Handler e (a * (b1 + b2 * (b2a * b2b * b2c * Maybe Text) + b3)) =>
                  [a * (b1 + b2 * (b2a * b2b * b2c * Maybe Text) + b3)]
    -> [e] +      [a * (b1 + b2 * (b2a * b2b * b2c             ) + b3)]
tx18 = handleMap (_2 . _Right . _Left . _2 . _2 . _2) tryDrop2Nothing

tx19 :: Handler e (a * (b1 + b2 * (b2a * b2b * Maybe Text) + b3)) =>
                  [a * (b1 + b2 * (b2a * b2b * Maybe Text) + b3)]
    -> [e] +      [a * (b1 + b2 * (b2a * b2b             ) + b3)]
tx19 = handleMap (_2 . _Right . _Left . _2 . _2) tryDrop2Nothing

tx19a :: [a * (b1 + b2 * (XmlNameId * b1b) + b3)]
      -> [a * (b1 + b2 * (            b1b) + b3)]
tx19a = over (each . _2 . _Right . _Left . _2) snd
