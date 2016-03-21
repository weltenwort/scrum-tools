module App.Router where

import Hop
import Hop.Matchers
import Hop.Navigate
import Hop.Types


type alias Location =
    Hop.Types.Location


type Route
    = NotFound
    | NoRetro
    | RetroOverview String


matchers : List (Hop.Types.PathMatcher Route)
matchers =
    [ Hop.Matchers.match1 NoRetro "/"
    , Hop.Matchers.match2 RetroOverview "/" Hop.Matchers.str
    ]


createRouter : Hop.Types.Router Route
createRouter =
    Hop.new 
        { matchers = matchers
        , notFound = NotFound
        }


navigateTo = Hop.Navigate.navigateTo
