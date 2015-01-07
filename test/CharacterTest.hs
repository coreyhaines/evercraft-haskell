module CharacterTest where

import Test.Framework
import Test.Framework.Providers.HUnit

import Test.HUnit as HUnit

import EverCraft

character_attributes :: Test.Framework.Test
character_attributes = testGroup "Testing Character Attributes" [
                       testCase "armor class defaults to 10" $ 10 @?=armorclass newCharacter,
                       testCase "hitpoints default to 5" $ 5 @?=hitpoints newCharacter
                       ]

alive_tests :: Test.Framework.Test
alive_tests = testGroup "Testing the state of a character's life" [
  testCase "More than 0 hitpoints is alive" $ isAlive (newCharacter {hitpoints=1}) @?= True,
  testCase "0 hitpoints is dead" $ isAlive (newCharacter {hitpoints=0}) @?= False
  ]

changing_hitpoints_tests :: Test.Framework.Test
changing_hitpoints_tests = testGroup "Adjusting character hitpoints" [
  testCase "Can subtract a hit point" $ hitpoints (subtractHitpoints 1 defaultCharacter) @?= (hitpoints defaultCharacter - 1),
  testCase "Can subtract more than one hit point" $ hitpoints (subtractHitpoints 3 defaultCharacter) @?= (hitpoints defaultCharacter - 3)
  ]

tests = [character_attributes, alive_tests, changing_hitpoints_tests]


