module Common.Navbar where

import Bootstrap.Html exposing (..)
import Html exposing (Html, text)
import Html.Shorthand exposing (..)


view : String -> Html
view title =
    navbarDefault' "navbar-fixed-top navbar-inverse"
        [ container_
            [ navbarHeader_
                [ a'
                    { class = "navbar-brand"
                    , href = "#/"
                    }
                    [ text title
                    ]
                ]
            , div'
                { class = "collapse navbar-collapse"
                }
                []
            ]
        ]
