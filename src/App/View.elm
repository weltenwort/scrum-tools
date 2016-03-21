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
    div_
        [ viewNavbar model
        , container_
            [ viewChildRoutes address model
            ]
        ]


viewChildRoutes address model =
    case model.route of
        App.Router.RetroOverview _ ->
            Pages.Retro.View.view model.retro
        _ ->
            Pages.NoRetro.View.view (Signal.forwardTo address (\action -> App.Action.Page (App.Action.NoRetro action)))


viewNavbar : App.Model.Model -> Html
viewNavbar model =
    let
        navbarBrand = model.retro
            |> Maybe.map .name
            |> Maybe.withDefault "Scrum Tools"
    in
        navbarDefault' "navbar-fixed-top navbar-inverse"
            [ container_
                [ navbarHeader_
                    [ a'
                        { class = "navbar-brand"
                        , href = "#/"
                        }
                        [ text navbarBrand
                        ]
                    ]
                , div'
                    { class = "collapse navbar-collapse"
                    }
                    []
                ]
            ]
