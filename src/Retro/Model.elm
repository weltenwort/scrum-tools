module Retro.Model where

import Dict

import Activity.Model


type alias Id =
    String


type alias Model =
    { id : Id
    , name : String
    , activityIds : List Activity.Model.Id
    }


type alias Collection = Dict.Dict Id Model


initial : String -> Model
initial id =
    { activityIds = []
    , id = id
    , name = "Unnamed Retrospective"
    }


initialCollection : Collection
initialCollection =
    Dict.empty


getRetro : Id -> Collection -> Maybe Model
getRetro =
    Dict.get


hasRetro : Id -> Collection -> Bool
hasRetro =
    Dict.member
