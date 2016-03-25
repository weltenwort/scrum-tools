module Pages.NoRetro.View where

import Bootstrap.Html exposing (..)
import Html exposing (Html, text)
import Html.Shorthand exposing (..)

import Common.Layout
import Common.Navbar
import Pages.NoRetro.Update


view : Signal.Address Pages.NoRetro.Update.Action -> Html
view address =
    let
        navbar = Common.Navbar.view "Scrum Tools"
        content = row_
            [ colXsOffset_ 6 3
                [ div_
                    [ btnPrimary'
                        "btn-block"
                        { btnParam
                        | label = Just "Create a new Retrospective"
                        }
                        address Pages.NoRetro.Update.CreateRetro
                    ]
                ]
            ]
    in
        Common.Layout.viewPage navbar content
