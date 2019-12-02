#!/usr/bin/env runhaskell

import Control.Monad

part1 = sum . map (subtract 2 . (`div` 3))

part2 = sum . map fuel
    where fuel x
            | f < 0     = 0
            | otherwise = f + fuel f
            where f = (x `div` 3) - 2

main = do
    input <- map read <$> lines <$> readFile "input"
    putStrLn . show $ part1 input
    putStrLn . show $ part2 input
