module AbilityTests where

import Test.Framework
import Test.Framework.Providers.HUnit

import Test.HUnit as HUnit

import EverCraft


ability_modifier_tests :: Test.Framework.Test
ability_modifier_tests  = testGroup "Character has ability scores" [
  testCase "they default to 10" $ default_ability_scores @?= [10,10,10,10,10,10],
  testCase "they can be set" $ set_ability_scores @?= [1,2,3,4,5,6]
  ]

default_ability_scores = abilities_as_list defaultCharacter

set_ability_scores = abilities_as_list defaultCharacter {abilities = set_abilities}
  where set_abilities = newAbilities{strength=1,dexterity=2,constitution=3,wisdom=4,intelligence=5,charisma=6}

abilities_as_list character = [strength a, dexterity a, constitution a, wisdom a, intelligence a, charisma a]
  where a = abilities character

tests = [ability_modifier_tests]
