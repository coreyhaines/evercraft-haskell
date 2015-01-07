module AttackingTests where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit as HUnit

import EverCraft

player = newCharacter{name="Player"}
opponent = newCharacter{name="Opponent"}

simple_attack_tests :: Test.Framework.Test
simple_attack_tests = testGroup "Executing attacks with default players" [
  testCase "No damage if attack is unsuccessful" $ currentHitpoints (runAttack player opponent (armorClass opponent - 1)) @?= maxHitpoints opponent,
  testCase "Opponent is damaged if attack is successful" $ currentHitpoints (runAttack player opponent (armorClass opponent)) @?= maxHitpoints opponent - damageForAttack player (armorClass opponent)
  ]

damage_calculation_tests :: Test.Framework.Test
damage_calculation_tests = testGroup "Calculating the damage for a roll" [
  testCase "Base character with non-critical roll causes 1 damage" $ damageForAttack defaultCharacter 11 @?= baseNoncriticalDamage,
  testCase "Base character with critical roll causes 2 damage" $ damageForAttack defaultCharacter criticalRoll @?= baseCriticalDamage,
  testCase "Modified character with non-critical roll gets modifier added to damage" $ damageForAttack player{abilities=newAbilities{strength=15}} 11 @?= baseNoncriticalDamage + abilityModifier 15,
  testCase "Modified character with critical roll gets modifier added to damage" $ damageForAttack player{abilities=newAbilities{strength=15}} criticalRoll @?= baseCriticalDamage + abilityModifier 15
  ]

checking_for_hit_tests :: Test.Framework.Test
checking_for_hit_tests = testGroup "Checking to see if a roll hits" [
    testCase "if roll is greater than armorclass, it hits" $ attackIsSuccessful player opponent (armorClass opponent + 1) @?= True,
    testCase "if roll is equal to armorclass, it hits" $ attackIsSuccessful player opponent (armorClass opponent) @?= True,
    testCase "if roll is less than armorclass, it misses" $ attackIsSuccessful player opponent (armorClass opponent - 1) @?= False
  ]

tests = [simple_attack_tests, damage_calculation_tests, checking_for_hit_tests]
