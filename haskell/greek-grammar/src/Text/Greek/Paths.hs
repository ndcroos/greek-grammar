{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Text.Greek.Paths where

import System.FilePath

sblgntOsisPath :: FilePath
sblgntOsisPath = "data" </> "sblgnt-osis" </> "SBLGNT" <.> "osis" <.> "xml"

agdaSblgntPath :: FilePath
agdaSblgntPath = "agda" </> "Text" </> "Greek" </> "SBLGNT"

unicodeDataPath :: FilePath
unicodeDataPath = "data" </> "ucd" </> "UnicodeData" <.> "txt"

haskellUnicodeScriptPath :: FilePath
haskellUnicodeScriptPath = "src" </> "Text" </> "Greek" </> "Script" </> "UnicodeTokenPairs" <.> "hs"