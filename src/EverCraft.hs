module EverCraft where

data Alignment =  Good | Evil | Neutral
                  deriving Show

data Character = Character {name::String, alignment::Alignment, armorclass, hitpoints::Integer}
                  deriving Show
defaultCharacter :: Character
defaultCharacter = Character {name="", alignment=Neutral, armorclass=10, hitpoints=5}

newCharacter = defaultCharacter

isAlive :: Character -> Bool
isAlive character = hitpoints character > 0

attackHits :: Character -> Integer -> Bool
attackHits character roll = roll >= armorclass character

