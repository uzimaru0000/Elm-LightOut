module Update exposing (..)

import Models exposing (..)
import Messages exposing (..)
import Random

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Click id ->
            update Check { model | lightList = List.map (getNewList id) model.lightList }
        NewGame list ->
            let
                newList = List.foldl (\id lights -> List.map (getNewList id) lights) model.lightList list
            in
              { model | lightList = newList } ! []
        Check ->
            { model | clear = List.all (\x -> x.on == True) model.lightList } ! []
        Reset ->
            (init, Random.generate NewGame (createNewGame 5 init.lightList))

toggleLight : Light -> Light
toggleLight light =
    { light | on = if light.on then False else True }

getNewList : (Int, Int) -> Light -> Light
getNewList (x, y) light =
    let
        idList = 
            [ (x, y)
            , (x-1, y)
            , (x+1, y)
            , (x, y-1)
            , (x, y+1)
            ]
    in
        if flip List.any idList <| (==) light.id then
            toggleLight light
        else
            light

createNewGame : Int -> List Light -> Random.Generator (List (Int, Int))
createNewGame n list =
    Random.list n <| Random.pair (Random.int 0 4) (Random.int 0 4)