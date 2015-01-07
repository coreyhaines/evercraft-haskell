module AttackingTests where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit as HUnit

import EverCraft

player = newCharacter{name="Player"}
opponent = newCharacter{name="Opponent"}

simple_attack_tests :: Test.Framework.Test
simple_attack_tests = testGroup "Executing attacks with default players" [
  testCase "No damage if roll is less than opponents armor class" $ currentHitpoints (runAttack player opponent (armorClass opponent - 1)) @?= maxHitpoints opponent
  ]

damage_calculation_tests :: Test.Framework.Test
damage_calculation_tests = testGroup "Calculating the damage for a roll" [
  testCase "Base character with non-critical roll causes 1 damage" $ damageForAttack defaultCharacter 11 @?= baseNoncriticalDamage,
  testCase "Base character with critical roll causes 2 damage" $ damageForAttack defaultCharacter criticalRoll @?= baseCriticalDamage
  ]

tests = [simple_attack_tests, damage_calculation_tests]
