> module EverCraft where
>

Some example code
-----------------
let c = MakeCharacter ("Corey", Good)
c
getName c
let c2 = setName c "Sarah"
c2

>
> data Alignment =  Good | Evil | Neutral
>                   deriving Show
>
> newtype Character = MakeCharacter (String, Alignment)
>                     deriving Show
>
> getName :: Character -> String
> getName (MakeCharacter (name, _)) = name
>
> setName :: Character -> String -> Character
> setName (MakeCharacter (_, alignment)) newName = MakeCharacter (newName, alignment)
>
> getAlignment :: Character -> Alignment
> getAlignment (MakeCharacter (_, alignment)) = alignment
