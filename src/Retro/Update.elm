module Retro.Update where

import Effects exposing (Effects)
import Response exposing (Response)

import Activity.Model
import Retro.Action
import Retro.Model


type alias ActivityModel = Activity.Model.Model
type alias RetroModel = Maybe Retro.Model.Model
type alias RetroAction = Retro.Action.Action
type alias RetroResponse = Response RetroModel RetroAction


update : RetroAction -> RetroModel -> RetroResponse
update action maybeRetro =
    case action of
        Retro.Action.Create id ->
            Retro.Model.initial id
                |> Response.withNone
                |> Response.mapModel Just

        Retro.Action.AddActivity id ->
            maybeRetro
                |> Maybe.map (addActivity (Activity.Model.initial id))
                |> Response.withNone


addActivity : ActivityModel -> Retro.Model.Model -> Retro.Model.Model
addActivity activity retro =
    { retro
    | activities = activity :: retro.activities
    }
