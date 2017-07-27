{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE MagicHash, UnboxedTuples #-}

module Main where

import GHC.Exts         ( addrToAny# )
import GHC.Ptr          ( Ptr(..) )
import System.Info      ( os, arch )
import Encoding
import GHCi.ObjLink
import Debug.Trace

main :: IO ()
main = do
  traceM "before initObjLinker"
  initObjLinker
  traceM "before loadObj"
  loadObj "/Users/saurabhnanda/projects/test-plugins/test-plugins/app/PluginMarkup.o"
  traceM "after loadObj"

  -- NOTE: I've hardcoded the symbol name that I obtained from running `symbols PluginMarkup.o`
  sym <- lookupSymbol "PluginMarkup_foliage_info"
  traceM "after lookupsymbol"
  traceM (show sym)

-- generateMarkup :: (UTCTime -> Html) -> IO ()
-- generateMarkup renderFn = void $ forM [1..10] $ const $ do
--   tm <- getCurrentTime
--   writeFile "/tmp/output.html" (renderHtml $ renderFn tm) 


-- [
--   GhcError {errMsg = "app/PluginMarkup.hs:9:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5\8217\n    Use -v to see a list of the files searched for."},
--   GhcError {errMsg = "app/PluginMarkup.hs:10:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5\8217\n    Use -v to see a list of the files searched for."},
--   GhcError {errMsg = "app/PluginMarkup.hs:11:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5.Attributes\8217\n    Use -v to see a list of the files searched for."},
--   GhcError {errMsg = "app/PluginMarkup.hs:12:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5.Attributes\8217\n    Use -v to see a list of the files searched for."},GhcError {errMsg = "app/PluginMarkup.hs:9:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5\8217\n    Use -v to see a list of the files searched for."},GhcError {errMsg = "app/PluginMarkup.hs:10:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5\8217\n    Use -v to see a list of the files searched for."},GhcError {errMsg = "app/PluginMarkup.hs:11:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5.Attributes\8217\n    Use -v to see a list of the files searched for."},GhcError {errMsg = "app/PluginMarkup.hs:12:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5.Attributes\8217\n    Use -v to see a list of the files searched for."}]
