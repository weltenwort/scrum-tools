module Retro.Update where

import Effects exposing (Effects)
import Response exposing (Response)

import Retro.Action
import Retro.Model


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
