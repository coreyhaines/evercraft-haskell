module EverCraft where

data Alignment =  Good | Evil | Neutral
                  deriving Show

data Character = Character {name::String, alignment::Alignment, armorclass, hitpoints::Integer}
                  deriving Show
defaultCharacter :: Character
defaultCharacter = Character {name="", alignment=Neutral, armorclass=10, hitpoints=5}

newCharacter = defaultCharacter

attackHits :: Character -> Integer -> Bool
attackHits character roll
  | (armorclass character) <= roll = True
  | otherwise = False

