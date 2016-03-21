module App.Model where

import App.Router as App exposing (Route)
import Id.Model as Id exposing (Model, initialModel)


type alias Model =
    { id: Id.Model
    , route : App.Route
    }


initial : Model
initial =
    { id = Id.initialModel
    , route = App.NotFound
    }
