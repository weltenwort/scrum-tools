module App.View where

import Html exposing (Html)

import App.Model as App exposing (Model)
import App.Update as App exposing (Action)
import Pages.NoRetro.View


view : Signal.Address App.Action -> App.Model -> Html
view address model =
    case model.route of
        _ ->
            Pages.NoRetro.View.view
