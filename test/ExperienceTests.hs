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

tests = [raw_experience_tests]
