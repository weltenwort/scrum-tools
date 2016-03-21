module App.Model where

import App.Router as App exposing (Route)
import Id.Model as Id exposing (Model, initialModel)
import Retro.Model as Retro exposing (Model)


type alias Model =
    { id: Id.Model
    , retro : Maybe Retro.Model
    , route : App.Route
    }


initial : Model
initial =
    { id = Id.initialModel
    , retro = Nothing
    , route = App.NotFound
    }
