module App.Update where

import Effects exposing (Effects)

import App.Model exposing (Model, initialModel)

type Action
    = Nothing

init : (Model, Effects Action)
init =
    ( initialModel
    , Effects.none
    )

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        _ ->
            ( model
            , Effects.none
            )
