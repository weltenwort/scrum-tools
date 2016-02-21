module App.Model where

import Id.Model as Id exposing (Model, initialModel)


type alias Model =
    { id: Id.Model
    }


initialModel : Model
initialModel =
    { id = Id.initialModel
    }
