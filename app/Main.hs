{-# LANGUAGE OverloadedStrings #-}

module Main where

-- import Lib
import Language.Haskell.Interpreter
import Criterion.Main
import Data.Time
-- import Markup
-- import Text.Blaze.Html5 hiding (main)
-- import Text.Blaze.Html.Renderer.String


main :: IO ()
main = do
  x <- runInterpreter $ do
    spath <- get searchPath
    -- set [installedModulesInScope := True]
    liftIO $ putStrLn ("SEARCH PATH: " ++ (show spath))
    liftIO $ putStrLn "before setImportsQ"
    loadModules ["app/MyPlugin.hs"]
    setImportsQ
      [
        ("Prelude", Nothing)
      , ("Data.Monoid", Nothing)
      , ("Data.Time", Nothing)
      , ("MyPlugin", Nothing)
      ]
    liftIO $ putStrLn "before loadModules"
    -- setImportsQ [("MyPlugin", Nothing)]
    renderViaPlugin <- interpret "foo" (as :: IO [UTCTime])
    return renderViaPlugin

  case x of
    Left e -> putStrLn ("Error while running the interpreter: " ++ (show e))
    Right fooViaPlugin -> defaultMain
      [
        bench "without hint" $ nfIO $ foo 
      , bench "with hint" $ nfIO $ fooViaPlugin
      ]

foo :: IO [UTCTime]
foo = do
  x <- getCurrentTime
  return $ zipWith (\tm d -> addUTCTime (fromIntegral d) tm) (replicate 10000 x) [1..]

-- generateMarkup :: (UTCTime -> Html) -> IO ()
-- generateMarkup renderFn = do
--   tm <- getCurrentTime
--   writeFile "/tmp/output.html" (renderHtml $ renderFn tm) 


-- [
--   GhcError {errMsg = "app/PluginMarkup.hs:9:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5\8217\n    Use -v to see a list of the files searched for."},
--   GhcError {errMsg = "app/PluginMarkup.hs:10:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5\8217\n    Use -v to see a list of the files searched for."},
--   GhcError {errMsg = "app/PluginMarkup.hs:11:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5.Attributes\8217\n    Use -v to see a list of the files searched for."},
--   GhcError {errMsg = "app/PluginMarkup.hs:12:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5.Attributes\8217\n    Use -v to see a list of the files searched for."},GhcError {errMsg = "app/PluginMarkup.hs:9:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5\8217\n    Use -v to see a list of the files searched for."},GhcError {errMsg = "app/PluginMarkup.hs:10:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5\8217\n    Use -v to see a list of the files searched for."},GhcError {errMsg = "app/PluginMarkup.hs:11:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5.Attributes\8217\n    Use -v to see a list of the files searched for."},GhcError {errMsg = "app/PluginMarkup.hs:12:1: error:\n    Failed to load interface for \8216Text.Blaze.Html5.Attributes\8217\n    Use -v to see a list of the files searched for."}]
