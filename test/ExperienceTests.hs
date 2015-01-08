module ExperienceTests where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit as HUnit

import EverCraft

basePlayer = newCharacter{name="Player"}
baseOpponent = newCharacter{name="Opponent"}

raw_experience_tests :: Test.Framework.Test
raw_experience_tests = testGroup "Getting experience from attacking" [
  testCase "No experience if attack is unsuccessful" $
      let newPlayer = player (runAttack basePlayer baseOpponent (armorClass baseOpponent - 1))
      in currentExperience newPlayer @?= currentExperience basePlayer,
  testCase "10 experience points are given if attack is successful" $
      let newPlayer = player (runAttack basePlayer baseOpponent (armorClass baseOpponent))
      in currentExperience newPlayer @?= baseExperienceForAttack + currentExperience basePlayer
  ]

leveling_tests :: Test.Framework.Test
leveling_tests = testGroup "Increasing levels based on experience" [
  testCase "No experience means level 1" $ currentLevel basePlayer @?= 1,
  testCase "999 experience means level 1" $ currentLevel (addExperience 999 basePlayer) @?= 1,
  testCase "1000 experience means level 2" $ currentLevel (addExperience 1000 basePlayer) @?= 2,
  testCase "1999 experience means level 2" $ currentLevel (addExperience 1999 basePlayer) @?= 2,
  testCase "2000 experience means level 3" $ currentLevel (addExperience 2000 basePlayer) @?= 3
  ]

tests = [raw_experience_tests, leveling_tests]
