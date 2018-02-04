{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString.Lazy.Char8 as BS
import qualified Data.Map                   as M
import           Data.Monoid                ((<>))
import           Hakyll
import           Text.Jasmine
import           Text.Pandoc.Options

-- staticWith :: Compiler (Item a) -> Pattern -> Rules ()
-- Can't assign a type without bringing in some typeclasses
staticWith compiler f = match f $ do
    route   idRoute
    compile compiler

directory :: (Pattern -> Rules a) -> String -> Rules a
directory act f = act $ fromGlob $ f ++ "/**"

compressJsCompiler :: Compiler (Item String)
compressJsCompiler = do
  let minifyJS = BS.unpack . minify . BS.pack . itemBody
  s <- getResourceString
  return $ itemSetBody (minifyJS s) s

mathBibCompiler :: Compiler (Item String)
mathBibCompiler = do
  csl <- load $ fromFilePath "csl/lsa.csl"
  bib <- load $ fromFilePath "bib/bib.bib"
  let ropt = defaultHakyllReaderOptions
  let wopt = defaultHakyllWriterOptions { writerHTMLMathMethod = MathJax ""
                                        , writerHtml5 = True
                                        }
  writePandocWith wopt <$> (getResourceBody >>= readPandocBiblio ropt csl bib)

mathCtx :: Context String
mathCtx = field "mathjax" $ \item -> do
  metadata <- getMetadata $ itemIdentifier item
  return $ if "mathjax" `M.member` metadata
           then "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-AMS_HTML-full\"></script>"
           else ""

myDefaultContext :: Context String
myDefaultContext = mathCtx <> defaultContext

postCtx :: Context String
postCtx = dateField "date" "%B %e, %Y" <> myDefaultContext

main :: IO ()
main = hakyll $ do
  directory (staticWith copyFileCompiler) "files" -- use mapM_ w/lists of dirs
  staticWith biblioCompiler "bib/*"
  staticWith cslCompiler "csl/*"
  staticWith compressCssCompiler "css/*"
  staticWith compressJsCompiler "js/*"

  match (fromList ["about.md", "readings.md"]) $ do
    route   $ setExtension "html"
    compile $ mathBibCompiler
      >>= loadAndApplyTemplate "templates/default.html" myDefaultContext
      >>= relativizeUrls

  match "posts/*" $ do
    route   $ setExtension "html"
    compile $ mathBibCompiler
      >>= loadAndApplyTemplate "templates/post.html"  postCtx
      >>= loadAndApplyTemplate "templates/default.html" postCtx
      >>= relativizeUrls

  create ["archive.html"] $ do
    route   idRoute
    compile $ do
      posts <- recentFirst =<< loadAll "posts/*"
      let archiveCtx = listField "posts" postCtx (return posts) <>
                       constField "title" "Archives"            <>
                       myDefaultContext
      makeItem ""
        >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
        >>= loadAndApplyTemplate "templates/default.html" archiveCtx
        >>= relativizeUrls

  match "index.md" $ do
    route   $ setExtension "html"
    compile $ do
      let indexCtx = constField "title" "Home" <> myDefaultContext
      getResourceBody
      mathBibCompiler
        >>= applyAsTemplate indexCtx
        >>= loadAndApplyTemplate "templates/default.html" indexCtx
        >>= relativizeUrls

  match "templates/*" $ compile templateBodyCompiler
