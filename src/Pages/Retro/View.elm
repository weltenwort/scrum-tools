module Pages.Retro.View where

import Html exposing (Html, text)

import Common.Layout
import Common.Navbar
import Retro.Model as Retro exposing (Model)


view : Maybe Retro.Model -> Html
view maybeRetro =
    case maybeRetro of
        Just retro ->
            viewRetro retro
        Nothing ->
            viewLoading


viewRetro retro =
    let
        navbar = Common.Navbar.view retro.name
        content = text retro.name
    in
        Common.Layout.viewPage navbar content


viewLoading =
    let
        navbar = Common.Navbar.view "Scrum Tools"
        content = text "loading retro..."
    in
        Common.Layout.viewPage navbar content
