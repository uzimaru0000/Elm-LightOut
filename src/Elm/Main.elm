module Main exposing (..)

import Html exposing (Html, program, text)
import Models exposing (..)
import Messages exposing (..)
import Update exposing (..)
import View exposing (..)
import Random

-- main

main : Program Never Model Msg
main =
    program
        { init = (init, Random.generate NewGame (createNewGame 5 init.lightList))
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
