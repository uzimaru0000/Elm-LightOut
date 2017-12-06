module Models exposing (..)

type alias Light =
    { on : Bool
    , id : (Int, Int)
    }

type alias Model = 
    { lightList : List Light
    , clear : Bool
    }

init : Model
init =
    Model 
    (List.range 0 4
    |> List.map (\y -> List.range 0 4 |> List.map (flip (,) y))
    |> List.concat
    |> List.map (\t -> Light True t))
    False