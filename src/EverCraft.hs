module EverCraft where

data Alignment =  Good | Evil | Neutral
                  deriving Show

data Abilities = Abilities {strength, dexterity, constitution, wisdom, intelligence, charisma::Integer}
                  deriving Show
defaultAbilities :: Abilities
defaultAbilities = Abilities {strength=10, dexterity=10, constitution=10, wisdom=10, intelligence=10, charisma=10}
newAbilities = defaultAbilities

data Character = Character {name::String, alignment::Alignment, armorclass, hitpoints::Integer, abilities::Abilities}
                  deriving Show
defaultCharacter :: Character
defaultCharacter = Character {name="", alignment=Neutral, armorclass=10, hitpoints=5, abilities=defaultAbilities}
newCharacter = defaultCharacter

abilityModifier :: Integer -> Integer
abilityModifier abilityScore = (abilityScore - 10) `div` 2

modifiedAttackRoll :: Character -> Integer -> Integer
modifiedAttackRoll character original_roll =
  original_roll + abilityModifier (strength $ abilities character)

modifiedDamage :: Character -> Integer -> Bool -> Integer
modifiedDamage character original_damage isCriticalHit = if damage < 1 then 1 else damage
  where damage = original_damage + (abilityModifier (strength $ abilities character)) * if isCriticalHit then 2 else 1

subtractHitpoints :: Integer -> Character -> Character
subtractHitpoints amount character = character {hitpoints=(hitpoints character - amount)}

isAlive :: Character -> Bool
isAlive character = hitpoints character > 0

attackHits :: Integer -> Character -> Bool
attackHits roll character = roll >= armorclass character

attack :: Character -> Integer -> Character
attack character roll
  | roll == 20 = subtractHitpoints 2 character
  | attackHits roll character = subtractHitpoints 1 character
  | otherwise = character

