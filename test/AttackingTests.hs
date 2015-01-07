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

tests = [simple_attack_tests]
