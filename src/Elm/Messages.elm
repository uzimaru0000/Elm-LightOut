module Messages exposing (..)

type Msg = Click (Int, Int)
         | NewGame (List (Int, Int))
         | Check
         | Reset