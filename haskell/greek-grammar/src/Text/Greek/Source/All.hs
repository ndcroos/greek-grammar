{-# LANGUAGE RankNTypes #-}

module Text.Greek.Source.All where

import Prelude hiding (Word, words)
import Text.Greek.Paths
import Text.Greek.Xml.Common
import Text.Greek.Xml.Parse
import qualified Control.Lens as Lens
import qualified Text.Greek.Script.Word as Word
import qualified Text.Greek.Source.Sblgnt as SBL
import qualified Text.Greek.Source.Work as Work

loadAll :: IO (Either [XmlError] [Work.Indexed [Word.Indexed Word.Basic Word.SourceInfo]])
loadAll = do
  sblgntResult <- loadSblgnt
  return $ do
    sblgntWorks <- sblgntResult
    let allWorks = sblgntWorks
    let indexedWorks = Work.indexBasic allWorks
    let indexedWorksWords = Lens.over (Lens.each . Work.content) Word.indexBasic indexedWorks
    return indexedWorksWords

loadSblgnt :: IO (Either [XmlError] [Work.Basic [Word.Word Word.Basic Word.SourceInfo]])
loadSblgnt = (fmap . fmap) sblgntToWorks $ readParseEvents SBL.sblgntParser sblgntXmlPath

sblgntToWorks :: SBL.Sblgnt -> [Work.Basic [Word.Word Word.Basic Word.SourceInfo]]
sblgntToWorks (SBL.Sblgnt _ _ bs) = fmap sblgntBookToWork bs

sblgntBookToWork :: SBL.Book -> Work.Basic [Word.Word Word.Basic Word.SourceInfo]
sblgntBookToWork (SBL.Book _ t ps) = Work.Work info words
  where
    info = (Work.SourceSblgnt, (Work.Title t))
    addParagraphIndex = zip (fmap Word.ParagraphIndex [0..])
    words = (concatMap (\(i, x) -> sblgntParagraphToWords i x) . addParagraphIndex $ ps)

sblgntParagraphToWords :: Word.ParagraphIndex -> SBL.BookParagraph -> [Word.Word Word.Basic Word.SourceInfo]
sblgntParagraphToWords i = fmap (sblWordToWord i) . concatMap (Lens.toListOf SBL._ItemWord) . concat . Lens.toListOf SBL._BookParagraphContent

sblWordToWord :: Word.ParagraphIndex -> SBL.Word -> Word.Word Word.Basic Word.SourceInfo
sblWordToWord i (SBL.Word (t, f) e _ _) = Word.Word (e, i) (Word.SourceInfo (Word.Source t) f)
