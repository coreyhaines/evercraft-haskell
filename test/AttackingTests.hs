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
  attackHits (armorclass c + 1) c
  where c = defaultCharacter

meets_armor_class = True @?=
  attackHits (armorclass c) c
  where c = defaultCharacter

less_than_armor_class = False @?=
  attackHits (armorclass c - 1) c
  where c = defaultCharacter

attacking_tests :: Test.Framework.Test
attacking_tests = testGroup "Attacking" [
  testCase "Character's hit points don't change if no hit" no_change_if_not_hit,
  testCase "Character loses 1 hit point if hit" lose_a_hitpoint,
  testCase "Character loses 2 hit point if a natural 20 is rolled" natural_20_loses_2_hitpoints
  ]

no_change_if_not_hit = currentHitpoints c' @?= currentHitpoints c
  where c  = defaultCharacter
        c' = attack c (armorclass c - 1)

lose_a_hitpoint = currentHitpoints c' @?= (currentHitpoints c - 1)
  where c  = defaultCharacter
        c' = attack c (armorclass c + 1)

natural_20_loses_2_hitpoints = currentHitpoints c' @?= (currentHitpoints c - 2)
  where c  = defaultCharacter
        c' = attack c 20

tests = [detecting_hit_tests, attacking_tests]
