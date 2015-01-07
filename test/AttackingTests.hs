module AttackingTests where

import Test.Framework
import Test.Framework.Providers.HUnit

import Test.HUnit as HUnit

import EverCraft

detecting_hit_tests :: Test.Framework.Test
detecting_hit_tests = testGroup "Detecting Hits" [
  testCase "Hits if roll is above armor class" beats_armor_class,
  testCase "Hits if roll is right at armor class" meets_armor_class,
  testCase "Misses if roll is less than armor class" less_than_armor_class
  ]

beats_armor_class = True @?=
  attackHits c 11
  where c = defaultCharacter

meets_armor_class = True @?=
  attackHits c (armorclass c)
  where c = defaultCharacter

less_than_armor_class = False @?=
  attackHits c (armorclass c - 1)
  where c = defaultCharacter

tests = [detecting_hit_tests]
