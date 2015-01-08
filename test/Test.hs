module Main where

import Test.Framework

import Test.HUnit
import CharacterTest
import AttackingTests
import AbilityTests
import ExperienceTests

import System.Exit

tests = CharacterTest.tests ++ AttackingTests.tests ++ AbilityTests.tests ++ ExperienceTests.tests

-- main::IO()
-- main = do
--     results <- runTestTT tests
--     let errs = errors results
--         fails = failures results
--     exitWith (codeGet errs fails)

main = defaultMain Main.tests

codeGet errs fails
 | fails > 0       = ExitFailure 2
 | errs > 0        = ExitFailure 1
 | otherwise       = ExitSuccess
