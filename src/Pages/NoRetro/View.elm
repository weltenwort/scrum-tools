module Pages.NoRetro.View where

import Bootstrap.Html exposing (..)
import Html exposing (Html, text)
import Html.Shorthand exposing (..)

import Pages.NoRetro.Update


view : Signal.Address Pages.NoRetro.Update.Action -> Html
view address =
    row_
        [ colXs_ 12
            [ div_
                [ text "no retro"
                , button_ "create" address Pages.NoRetro.Update.CreateRetro
                ]
            ]
        ]
