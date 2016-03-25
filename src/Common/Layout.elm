module Common.Layout where

import Bootstrap.Html exposing (..)
import Html exposing (Html, text)
import Html.Shorthand exposing (..)


viewPage : Html -> Html -> Html
viewPage navbar content =
    div_
        [ navbar
        , container_
            [ content
            ]
        ]
