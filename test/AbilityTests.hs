module AbilityTests where

import Test.Framework
import Test.Framework.Providers.HUnit

import Test.HUnit as HUnit

import EverCraft


ability_setting_tests :: Test.Framework.Test
ability_setting_tests  = testGroup "Character has ability scores" [
  testCase "they default to 10" $ default_ability_scores @?= [10,10,10,10,10,10],
  testCase "they can be set" $ set_ability_scores @?= [1,2,3,4,5,6]
  ]

default_ability_scores = abilities_as_list defaultCharacter

set_ability_scores = abilities_as_list defaultCharacter {abilities = set_abilities}
  where set_abilities = newAbilities{strength=1,dexterity=2,constitution=3,wisdom=4,intelligence=5,charisma=6}

abilities_as_list character = [strength a, dexterity a, constitution a, wisdom a, intelligence a, charisma a]
  where a = abilities character

ability_modifier_tests :: Test.Framework.Test
ability_modifier_tests = testGroup "Character abilities have a modifier associated with their value" [
    test_modifier 1 (-5), -- LOL
    test_modifier 2 (-4), -- LOL
    test_modifier 3 (-4), -- LOL
    test_modifier 4 (-3), -- LOL
    test_modifier 5 (-3), -- LOL
    test_modifier 6 (-2), -- LOL
    test_modifier 7 (-2), -- LOL
    test_modifier 8 (-1), -- LOL
    test_modifier 9 (-1), -- LOL
    test_modifier 10 0, -- LOL
    test_modifier 11 0, -- LOL
    test_modifier 12 1, -- LOL
    test_modifier 13 1, -- LOL
    test_modifier 14 2, -- LOL
    test_modifier 15 2, -- LOL
    test_modifier 16 3, -- LOL
    test_modifier 17 3, -- LOL
    test_modifier 18 4, -- LOL
    test_modifier 19 4, -- LOL
    test_modifier 20 5 -- LOL
  ]

test_modifier score modifier = testCase "modifier score" $ abilityModifier score @?= modifier

strength_modifier_tests :: Test.Framework.Test
strength_modifier_tests = testGroup "Strength modifier modifies aspects" [
    testCase "Strength modifier modifies attack roll" $ modifiedAttackRoll (newCharacter{abilities=newAbilities{strength=2}}) 7 @?= (7 + abilityModifier 2),
    testCase "Strength modifier modifies damage" $ modifiedDamage (newCharacter{abilities=newAbilities{strength=18}}) 1 False @?= (1 + abilityModifier 18),
    testCase "Strength modifier is doubled on critical hit" $ modifiedDamage (newCharacter{abilities=newAbilities{strength=18}}) 1 True @?= (1 + 2 * abilityModifier 18),
    testCase "Minimum damage is 1, regardless of strength modifier" $ modifiedDamage (newCharacter{abilities=newAbilities{strength=2}}) 1 True @?= 1
  ]

tests = [ability_setting_tests, ability_modifier_tests, strength_modifier_tests]
