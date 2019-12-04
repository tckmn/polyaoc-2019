#!/usr/bin/env runhaskell

import Data.List

preprocess =
    map (map length . group) .
    filter (all (uncurry (<=)) . (zip <*> tail)) .
    map show

howMany = (length .) . filter . any
part1 = howMany (>=2)
part2 = howMany (==2)

main = do
    input <- readFile "input"
    putStrLn . show $
        let (a,b) = span (/='-') input
            nums = [read a..read $ tail b] :: [Int]
            counts = preprocess nums
        in map ($ counts) [part1, part2]
