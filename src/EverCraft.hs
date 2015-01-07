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

modifiedDamage :: Character -> Damage -> Bool -> Damage
modifiedDamage character originalDamage isCriticalHit = if damage < 1 then 1 else damage
  where damage = originalDamage + (abilityModifier (strength $ abilities character)) * if isCriticalHit then 2 else 1

modifiedAttackRoll :: Character -> Roll -> Roll
modifiedAttackRoll character originalRoll = originalRoll + abilityModifier (strength $ abilities character)

armorClass :: Character -> Integer
armorClass character = baseArmorClass + abilityModifier (dexterity $ abilities character)

addDamage :: Damage -> Character -> Character
addDamage amount character = character {damage=(damage character + amount)}

isAlive :: Character -> Bool
isAlive character = currentHitpoints character > 0

criticalRoll = 20
baseNoncriticalDamage = 1
baseCriticalDamage = 2

isCriticalHit :: Roll -> Bool
isCriticalHit roll = roll == criticalRoll

attackIsSuccessful :: Character -> Character -> Roll -> Bool
attackIsSuccessful player opponent roll = (modifiedAttackRoll player roll) >= armorClass opponent

damageForAttack :: Character -> Roll -> Damage
damageForAttack character roll = abilityModifier (strength $ abilities character) + damage
    where
  damage
    | isCriticalHit roll = baseCriticalDamage
    | otherwise = baseNoncriticalDamage

runAttack :: Character -> Character -> Roll -> Character
runAttack player opponent roll
  | attackIsSuccessful player opponent roll = addDamage (damageForAttack player roll) opponent
  | otherwise = opponent
