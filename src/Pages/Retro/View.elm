module Pages.Retro.View where

import Bootstrap.Html exposing (..)
import Either
import Html exposing (Html, text)
import Html.Shorthand exposing (..)

import Activity.Model
import App.Model
import Common.Layout
import Common.Navbar
import Pages.Retro.Action
import Retro.Model


type alias EitherActivityOrStub =
    Either.Either Activity.Model.Model Activity.Model.Id


view : Signal.Address Pages.Retro.Action.Action -> App.Model.Model -> Retro.Model.Id -> Html
view address model retroId =
    let
        maybeRetro = Retro.Model.getRetro retroId model.retros
    in
        case maybeRetro of
            Just retro ->
                viewRetro address model retro
            Nothing ->
                viewRetroLoading


viewRetro : Signal.Address Pages.Retro.Action.Action -> App.Model.Model -> Retro.Model.Model -> Html
viewRetro address model retro =
    let
        getEitherActivityOrStub id =
            id
                |> flip Activity.Model.getActivity model.activities
                |> Maybe.map Either.Left
                |> Maybe.withDefault (Either.Right id)
        activities = List.map getEitherActivityOrStub retro.activityIds
        navbar = Common.Navbar.view retro.name
        content = row_
            [ colXs_ 12
                [ row_
                    [ colXs_ 12
                        [ viewActivities activities
                        ]
                    ]
                , row_
                    [ colXs_ 12
                        [ btnPrimary'
                            "btn-block"
                            { btnParam
                            | label = Just "Add a new Activity"
                            }
                            address (Pages.Retro.Action.AddActivity retro.id)
                        ]
                    ]
                ]
            ]
    in
        Common.Layout.viewPage navbar content


viewActivities : List EitherActivityOrStub -> Html
viewActivities activities =
    div'
        { class = "list-group"
        }
        (List.map viewActivity activities)


viewActivity : EitherActivityOrStub -> Html
viewActivity activity =
    let
        name = Either.elim .name (always "Loading activity...") activity
        id = Either.elim .id identity activity
    in
        a'
            { class = "list-group-item"
            , href = "#/activity/" ++ id
            }
            [ h4'
                { class = "list-group-item-heading"
                }
                [ text name
                ]
            , p'
                { class = "list-group-item-text"
                }
                [ text "Unknown type"
                ]
            ]


viewRetroLoading =
    let
        navbar = Common.Navbar.view "Scrum Tools"
        content = text "loading retro..."
    in
        Common.Layout.viewPage navbar content
