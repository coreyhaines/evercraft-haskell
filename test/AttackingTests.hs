module AttackingTests where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit as HUnit

import EverCraft

basePlayer = newCharacter{name="Player"}
baseOpponent = newCharacter{name="Opponent"}

simple_attack_tests :: Test.Framework.Test
simple_attack_tests = testGroup "Executing attacks with default players" [
  testCase "No damage if attack is unsuccessful" $
    let newOpponent = opponent (runAttack basePlayer baseOpponent (armorClass baseOpponent - 1))
        expectedHitpoints = maxHitpoints baseOpponent
    in currentHitpoints newOpponent @?= expectedHitpoints,
  testCase "Opponent is damaged if attack is successful" $
    let newOpponent = opponent (runAttack basePlayer baseOpponent (armorClass baseOpponent))
        expectedHitPoints = maxHitpoints baseOpponent - damageForAttack basePlayer (armorClass baseOpponent)
    in currentHitpoints newOpponent @?= expectedHitPoints
  ]

damage_calculation_tests :: Test.Framework.Test
damage_calculation_tests = testGroup "Calculating the damage for a roll" [
  testCase "Base character with non-critical roll causes 1 damage" $ damageForAttack defaultCharacter 11 @?= baseNoncriticalDamage,
  testCase "Base character with critical roll causes 2 damage" $ damageForAttack defaultCharacter criticalRoll @?= baseCriticalDamage,
  testCase "Modified character with non-critical roll gets modifier added to damage" $ damageForAttack basePlayer{abilities=newAbilities{strength=15}} 11 @?= baseNoncriticalDamage + abilityModifier 15,
  testCase "Modified character with critical roll gets 2*modifier added to damage" $ damageForAttack basePlayer{abilities=newAbilities{strength=15}} criticalRoll @?= baseCriticalDamage + 2 * abilityModifier 15,
  testCase "Damage can't be less than 1" $ damageForAttack basePlayer{abilities=newAbilities{strength=1}} 11 @?= 1
  ]

checking_for_hit_tests :: Test.Framework.Test
checking_for_hit_tests = testGroup "Checking to see if a roll hits" [
  testCase "if roll is greater than armorclass, it hits" $ assertBool "" (attackIsSuccessful basePlayer baseOpponent (armorClass baseOpponent + 1)),
  testCase "if roll is equal to armorclass, it hits" $ assertBool "" (attackIsSuccessful basePlayer baseOpponent (armorClass baseOpponent)),
  testCase "if roll is less than armorclass, it misses" $ assertBool "" (not(attackIsSuccessful basePlayer baseOpponent (armorClass baseOpponent - 1)))
  ]

calculating_experience_tests :: Test.Framework.Test
calculating_experience_tests = testGroup "Player gets experience based on attack results" [
  ]


tests = [simple_attack_tests, damage_calculation_tests, checking_for_hit_tests]
