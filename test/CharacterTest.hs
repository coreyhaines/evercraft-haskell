module CharacterTest where

import Test.Framework
import Test.Framework.Providers.HUnit

import Test.HUnit as HUnit

import EverCraft

character_attributes :: Test.Framework.Test
character_attributes = testGroup "Testing Character Attributes" [
                       testCase "armor class defaults to 10" $ 10 @?=armorclass newCharacter,
                       testCase "damage defaults to 0" $ 0 @?=damage newCharacter
                       ]

hitpoint_calculation_tests :: Test.Framework.Test
hitpoint_calculation_tests = testGroup "Calculating hitpoints" [
  testCase "With 0 damage, player has base hitpoints" $ currentHitpoints defaultCharacter @?= baseHitpoints,
  testCase "Constitution modifier adjusts maxhitpoints" $ maxHitpoints (newCharacter{abilities=newAbilities{constitution=19}}) @?= baseHitpoints + abilityModifier 19,
  testCase "Constitution modifier can't adjust maxhitpoints lower than 1" $ maxHitpoints (newCharacter{abilities=newAbilities{constitution=1}}) @?= 1,
  testCase "Adding 1 damage subtracts one from currenthitpoint" $ currentHitpoints (addDamage 1 defaultCharacter) @?= (currentHitpoints defaultCharacter - 1),
  testCase "Adding damage twice subtracts both from currenthitpoints" $ currentHitpoints (addDamage 2 (addDamage 1 defaultCharacter)) @?= baseHitpoints - 3
  ]

alive_tests :: Test.Framework.Test
alive_tests = testGroup "Testing the state of a character's life" [
  testCase "More than 0 hitpoints is alive" $ isAlive newCharacter{damage=(baseHitpoints-1)} @?= True,
  testCase "0 hitpoints is dead" $ isAlive (addDamage baseHitpoints defaultCharacter) @?= False
  ]

tests = [character_attributes, hitpoint_calculation_tests, alive_tests]


