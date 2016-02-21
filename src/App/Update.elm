module App.Update where

import Effects exposing (Effects)

import App.Model as App exposing (Model, initialModel)
import Id.Update as Id exposing (init)


type Action
    = Nothing


init : (Int, Int) -> (App.Model, Effects Action)
init randomSeed =
    let
        initialId = Id.init randomSeed
        model = { initialModel
            | id = initialId
        }
    in
        ( model
        , Effects.none
        )


update : Action -> App.Model -> (Model, Effects Action)
update action model =
    case action of
        _ ->
            ( model
            , Effects.none
            )
