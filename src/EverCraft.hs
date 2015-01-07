module EverCraft where

data Alignment =  Good | Evil | Neutral
                  deriving Show

data Abilities = Abilities {strength, dexterity, constitution, wisdom, intelligence, charisma::Integer}
                  deriving Show
defaultAbilities :: Abilities
defaultAbilities = Abilities {strength=10, dexterity=10, constitution=10, wisdom=10, intelligence=10, charisma=10}
newAbilities = defaultAbilities

baseHitpoints = 5
baseArmorClass = 10
data Character = Character {name::String, alignment::Alignment, damage::Damage, abilities::Abilities}
                  deriving Show
defaultCharacter :: Character
defaultCharacter = Character {name="", alignment=Neutral, damage=0, abilities=defaultAbilities}
newCharacter = defaultCharacter

maxHitpoints :: Character -> Integer
maxHitpoints character = if hp < 1 then 1 else hp
  where hp = baseHitpoints + (abilityModifier (constitution $ abilities character))

currentHitpoints :: Character -> Integer
currentHitpoints character = maxHitpoints character - damage character

type Roll = Integer
type Damage = Integer

abilityModifier :: Integer -> Integer
abilityModifier abilityScore = (abilityScore - 10) `div` 2

modifiedAttackRoll :: Character -> Roll -> Roll
modifiedAttackRoll character originalRoll =
  originalRoll + abilityModifier (strength $ abilities character)

modifiedDamage :: Character -> Damage -> Bool -> Damage
modifiedDamage character originalDamage isCriticalHit = if damage < 1 then 1 else damage
  where damage = originalDamage + (abilityModifier (strength $ abilities character)) * if isCriticalHit then 2 else 1

armorClass :: Character -> Integer
armorClass character = baseArmorClass + abilityModifier (dexterity $ abilities character)

addDamage :: Damage -> Character -> Character
addDamage amount character = character {damage=(damage character + amount)}

isAlive :: Character -> Bool
isAlive character = currentHitpoints character > 0

attackHits :: Roll -> Character -> Bool
attackHits roll character = roll >= armorClass character

runAttack :: Character -> Character -> Roll -> Character
runAttack player opponent roll = opponent
