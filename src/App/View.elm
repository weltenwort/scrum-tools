module App.View where

import Bootstrap.Html exposing (..)
import Html exposing (Html, text)
import Html.Shorthand exposing (..)

import App.Action
import App.Model
import App.Router
import App.Update
import Pages.NoRetro.View
import Pages.Retro.View


view : Signal.Address App.Action.Action -> App.Model.Model -> Html
view address model =
    case model.route of
        App.Router.RetroOverview _ ->
            Pages.Retro.View.view (Signal.forwardTo address tagRetroPageAction) model.retro
        _ ->
            Pages.NoRetro.View.view (Signal.forwardTo address tagNoRetroPageAction)


tagNoRetroPageAction = App.Action.NoRetroPage >> App.Action.Page
tagRetroPageAction = App.Action.RetroPage >> App.Action.Page
