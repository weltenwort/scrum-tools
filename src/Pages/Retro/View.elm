module Pages.Retro.View where

import Html exposing (Html, text)

import Retro.Model as Retro exposing (Model)


view : Maybe Retro.Model -> Html
view maybeRetro =
    case maybeRetro of
        Just retro ->
            text retro.name
        Nothing ->
            text "loading retro..."
