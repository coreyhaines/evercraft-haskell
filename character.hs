data Alignment = Good
               | Evil
               | Neutral
               deriving Show

newtype Character = MakeCharacter (String, Alignment)
                    deriving Show

getCharacterName :: Character -> String
getCharacterName (MakeCharacter (name, _)) = name

setCharacterName :: Character -> String -> Character
setCharacterName (MakeCharacter (_, alignment)) newName = MakeCharacter (newName, alignment)
