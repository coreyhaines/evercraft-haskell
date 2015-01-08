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
baseExperienceForAttack = 10
data Character = Character {name::String, alignment::Alignment, experience::Integer, damage::Damage, abilities::Abilities}
                  deriving Show
defaultCharacter :: Character
defaultCharacter = Character {name="", alignment=Neutral, experience=0, damage=0, abilities=defaultAbilities}
newCharacter = defaultCharacter

maxHitpoints :: Character -> Integer
maxHitpoints character = if hp < 1 then 1 else hp
  where hp = baseHitpoints + (abilityModifier (constitution $ abilities character))

currentHitpoints :: Character -> Integer
currentHitpoints character = maxHitpoints character - damage character

currentExperience :: Character -> Integer
currentExperience = experience

addExperience :: Integer -> Character -> Character
addExperience amount player = player{experience=(currentExperience player) + amount}

levelLedge = 1000
currentLevel :: Character -> Integer
currentLevel player = 1 + currentExperience player `div` levelLedge

type Roll = Integer
type Damage = Integer

abilityModifier :: Integer -> Integer
abilityModifier abilityScore = (abilityScore - 10) `div` 2

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

rawDamageForAttack :: Character -> Roll -> Damage
rawDamageForAttack character roll = damage + abilityModifier (strength $ abilities character) * if isCriticalHit roll then 2 else 1
    where
  damage
    | isCriticalHit roll = baseCriticalDamage
    | otherwise = baseNoncriticalDamage

damageForAttack :: Character -> Roll -> Damage
damageForAttack character roll = if totalDamage >= 1 then totalDamage else 1
  where totalDamage = rawDamageForAttack character roll

data AttackResult = AttackResult{player,opponent::Character}
                    deriving Show

runAttack :: Character -> Character -> Roll -> AttackResult
runAttack player opponent roll
  | attackIsSuccessful player opponent roll = AttackResult{player=new_player,opponent=new_opponent}
  | otherwise = AttackResult{player=player, opponent=opponent}
    where new_player = (addExperience baseExperienceForAttack player)
          new_opponent = (addDamage (damageForAttack player roll) opponent)
