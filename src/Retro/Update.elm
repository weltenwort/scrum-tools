module Retro.Update where

import Dict
import Effects exposing (Effects)
import Response exposing (Response)

import Activity.Model
import Retro.Action
import Retro.Model


type alias ActivityId = Activity.Model.Id
type alias RetroModel = Retro.Model.Collection
type alias RetroAction = Retro.Action.Action
type alias RetroResponse = Response RetroModel RetroAction


update : RetroAction -> RetroModel -> RetroResponse
update action retros =
    case action of
        Retro.Action.Create retroId ->
            retros
                |> Dict.update
                    retroId
                    (\maybeRetro -> Maybe.oneOf [maybeRetro, Just (Retro.Model.initial retroId)])
                |> Response.withNone

        Retro.Action.AddActivity retroId activityId ->
            retros
                |> Dict.update
                    retroId
                    (Maybe.map (addActivity activityId))
                |> Response.withNone

        Retro.Action.NoOp ->
            retros
                |> Response.withNone


addActivity : ActivityId -> Retro.Model.Model -> Retro.Model.Model
addActivity activityId retro =
    { retro
    | activityIds = activityId :: retro.activityIds
    }
