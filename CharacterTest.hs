module CharacterTest where

import Test.Framework
import Test.Framework.Providers.HUnit

import Test.HUnit as HUnit

myLast :: [a] -> a
myLast (x:[]) = x
myLast (_:xs) = myLast xs

problem1 :: Test.Framework.Test
problem1 = testGroup "problem 1" [
           testCase "the last element [1,2,3,4]"    $ 4   @?= myLast [1,2,3,4],
           testCase "last element of ['x','y','z']" $ 'z' @?= myLast "xyz"
           ]

character_tests = [problem1]


