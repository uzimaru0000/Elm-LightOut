module View exposing (..)

import Html exposing (Html, div, text, br, span, button)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Models exposing (..)
import Messages exposing (Msg(..))

view : Model -> Html Msg
view model =
    div [] <|
        (List.foldl listing [] model.lightList
        |> List.map (\x -> List.map lightView x)
        |> List.intersperse [ br [] [] ]
        |> List.concat)
        ++
        [ div [] [ button [onClick Reset] [text "Reset"]] ]

listing : Light -> List (List Light) -> List (List Light)
listing light list =
    let
        (_, y) = light.id
        innerList = List.drop y list
                    |> List.head
        newList = 
            case innerList of
                Just inList ->
                    inList ++ [ light ]
                Nothing ->
                    [ light ]
        top = List.take y list
        bottom = List.drop (y+1) list
    in
        top ++ [ newList ] ++ bottom

lightView : Light -> Html Msg
lightView light =
    span [ style <| lightStyle light.on
         , onClick <| Click light.id
         ] []

lightStyle : Bool -> List (String, String)
lightStyle toggle =
    [ ("display", "inline-block")
    , ("box-sizing", "border-box")
    , ("width", "64px")
    , ("height", "64px")
    , ("margin", "1px")
    , ("border", "1px black solid")
    ] ++
    if toggle then
        [ ("background-color" , "#ADFF2F") ]
    else
        [ ("background-color", "#008000") ]