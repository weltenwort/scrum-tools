module Id.Model where

import Random.PCG as Random


type alias Model =
    { current : String
    , seed : Random.Seed
    }


initialModel : Model
initialModel =
    { current = ""
    , seed = Random.initialSeed2 0 0
    }
