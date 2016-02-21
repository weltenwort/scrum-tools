module App.View where

import Html

import App.Model exposing (Model)
import App.Update exposing (Action)


view : Signal.Address Action -> Model -> Html.Html
view address model =
    Html.div
        []
        [ Html.text model.id.current ]
