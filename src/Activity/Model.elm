module Activity.Model where


type alias Model =
    { id : String
    , name : String
    }


initial : String -> Model
initial id =
    { id = id
    , name = "Unnamed Activity"
    }
