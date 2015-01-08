module ExperienceTests where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit as HUnit

import EverCraft

player = newCharacter{name="Player"}
opponent = newCharacter{name="Opponent"}

raw_experience_tests :: Test.Framework.Test
raw_experience_tests = testGroup "Getting experience from attacking" [
  testCase "No experience if attack is unsuccessful" $ currentExperience (playerResult (runAttack player opponent (armorClass opponent - 1))) @?= currentExperience player,
  testCase "10 experience points are given if attack is successful" $ currentExperience (playerResult (runAttack player opponent (armorClass opponent))) @?= baseExperienceForAttack + currentExperience player
  ]

tests = [raw_experience_tests]
