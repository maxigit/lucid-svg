lucid-svg [![Hackage](https://img.shields.io/hackage/v/lucid-svg.svg?style=flat)](https://hackage.haskell.org/package/lucid-svg)
=========
Simple DSL for writing SVG, based on lucid

## Example

``` haskell
{-# LANGUAGE OverloadedStrings #-}

import Lucid.Svg
 
svg :: Svg () -> Svg ()
svg content = do
  doctype_
  with (svg11_ content) [width_ "300" , height_ "200"]

contents :: Svg ()
contents = do
  rect_   [width_ "100%", height_ "100%", fill_ "red"]
  circle_ [cx_ "150", cy_ "100", r_ "80", fill_ "green"]
  text_   [x_ "150", y_ "125", font_size_ "60", text_anchor_ "middle", fill_ "white"] "SVG"


main :: IO ()
main = do
  print $ svg contents
```

![SVG](http://i.imgur.com/dXu84xR.png)
