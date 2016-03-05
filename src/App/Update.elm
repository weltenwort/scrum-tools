module App.Update where

import Effects exposing (Effects)

import App.Model as App exposing (Model, initialModel)
import App.Router as App exposing (Route, RouteParams, createRouter)
import Id.Update as Id exposing (init)


type Action
    = NoOp
    | ShowRoute App.Route App.RouteParams


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


update : Action -> App.Model -> (App.Model, Effects Action)
update action model =
    case action of
        ShowRoute route _ ->
            ( {model | route = route}
            , Effects.none
            )
        _ ->
            ( model
            , Effects.none
            )


router =
    App.createRouter ShowRoute
