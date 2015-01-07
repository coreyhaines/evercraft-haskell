module CharacterTest where

import Test.Framework
import Test.Framework.Providers.HUnit

import Test.HUnit as HUnit

import Character

character_attributes :: Test.Framework.Test
character_attributes = testGroup "Testing Character Attributes" [
                       testCase "armor class defaults to 10" $ 10 @?=armorclass newCharacter,
                       testCase "hitpoints default to 5" $ 5 @?=hitpoints newCharacter
                       ]

character_tests = [character_attributes]


