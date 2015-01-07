> module EverCraft where
>

Some example code
-----------------
let c =  Character {name="Corey", alignment=Good, armorclass=10, hitpoints=5}
c

>
> data Alignment =  Good | Evil | Neutral
>                   deriving Show
>
> data Character = Character {name::String, alignment::Alignment, armorclass, hitpoints::Integer}
>                   deriving Show
> defaultCharacter :: Character
> defaultCharacter = Character {name="", alignment=Neutral, armorclass=10, hitpoints=5}
>
> newCharacter = defaultCharacter
