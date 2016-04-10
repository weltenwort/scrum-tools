module Activity.Model where

import Dict


type alias Id =
    String


type alias Model =
    { id : String
    , name : String
    }


type alias Collection =
    Dict.Dict Id Model


initial : String -> Model
initial id =
    { id = id
    , name = "Unnamed Activity"
    }


initialCollection : Collection
initialCollection =
    Dict.empty


getActivity : Id -> Collection -> Maybe Model
getActivity =
    Dict.get
