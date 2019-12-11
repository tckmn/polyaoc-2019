#!/usr/bin/env runhaskell

import Control.Monad
import Data.Function
import Data.List
import Data.List.Split

part1 = liftM2 (*) (count '1') (count '2') . minimumBy (compare `on` count '0') . map concat
    where count x = length . filter (==x)

part2 = foldl1 $ zipWith.zipWith $ f
    where f '2' x = g x
          f x   _ = g x
          g '0' = ' '
          g '1' = '#'
          g x   = x

main = do
    layers <- chunksOf 6 . chunksOf 25 . init <$> readFile "input"
    putStrLn . show    $ part1 layers
    putStrLn . unlines $ part2 layers
