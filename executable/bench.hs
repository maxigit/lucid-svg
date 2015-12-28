{-# LANGUAGE OverloadedStrings #-}

import Lucid.Svg
import Lucid (renderBS)
import Control.Monad

import qualified Data.ByteString.Lazy as BS
import qualified Data.Text.Lazy.IO as LT
import System.Environment (getArgs)

svg :: Svg () -> Svg ()
svg content = do
  doctype_
  with (svg11_ content) [version_ "1.1", width_ "300" , height_ "200"]

contents :: Svg ()
contents = do
  rect_   [width_ "100%", height_ "100%", fill_ "red"]
  circle_ [cx_ "150", cy_ "100", r_ "80", fill_ "green"]
  text_   [x_ "150", y_ "125", font_size_ "60", text_anchor_ "middle", fill_ "white"] "SVG"


main :: IO ()
main' = do
  print $ svg contents

bigContents n = svg (replicateM_ n contents)
main = do
  args <- getArgs
  case args of 
    [n] ->  do
              let bs = renderBS (bigContents (read n))
              BS.writeFile "bench-bs.svg" bs
    ["t", n] ->  do
              let bs = renderText (bigContents (read n))
              LT.writeFile "bench-text.svg" bs
    [_, n] ->  do
              let p = prettyText (bigContents (read n))
              LT.writeFile "bench-pretty.svg" p
