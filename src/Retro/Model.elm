module Retro.Model where

import Activity.Model as Activity exposing (Model)


type alias Model =
    { id : String
    , name : String
    , activities : List Activity.Model
    }


initial : String -> Model
initial id =
    { activities = []
    , id = id
    , name = "Unnamed Retro"
    }
