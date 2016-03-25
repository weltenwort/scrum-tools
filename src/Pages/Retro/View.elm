module Pages.Retro.View where

import Bootstrap.Html exposing (..)
import Html exposing (Html, text)
import Html.Shorthand exposing (..)

import Common.Layout
import Common.Navbar
import Pages.Retro.Action
import Retro.Model as Retro exposing (Model)


view : Signal.Address Pages.Retro.Action.Action -> Maybe Retro.Model -> Html
view address maybeRetro =
    case maybeRetro of
        Just retro ->
            viewRetro address retro
        Nothing ->
            viewLoading


viewRetro address retro =
    let
        navbar = Common.Navbar.view retro.name
        content = row_
            [ colXsOffset_ 6 3
                [ btnPrimary'
                    "btn-block"
                    { btnParam
                    | label = Just "Add a new Activity"
                    }
                    address Pages.Retro.Action.AddActivity
                ]
            ]
    in
        Common.Layout.viewPage navbar content


viewActivities activities =
    div_
        (List.map viewActivityEntry activities)


viewActivityEntry activity =
    text activity.name


viewLoading =
    let
        navbar = Common.Navbar.view "Scrum Tools"
        content = text "loading retro..."
    in
        Common.Layout.viewPage navbar content
