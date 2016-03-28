module App.Update where

import Debug
import Effects
import Effects.Extra.Infix exposing ((:>))
import Response exposing (Response)

import App.Action
import App.Model
import App.Router
import Id.Action
import Id.Update
import Pages.NoRetro.Update
import Pages.Retro.Action
import Retro.Action
import Retro.Update


type alias AppAction = App.Action.Action
type alias AppModel = App.Model.Model
type alias AppResponse = Response AppModel AppAction


init : (Int, Int) -> AppResponse
init randomSeed =
    let
        initialId = Id.Update.init randomSeed
        initialModel = App.Model.initial
        model = { initialModel
            | id = initialId
        }
    in
        model
            |> Response.withNone


update : AppAction -> AppModel -> AppResponse
update action model =
    let
        createRetro = Pages.NoRetro.Update.CreateRetro
        addActivity = Pages.Retro.Action.AddActivity
    in
        case action of
            -- Route Actions
            App.Action.Route (route, _) ->
                {model | route = route}
                    |> Response.withNone
            App.Action.Navigation path ->
                model
                    |> Response.withEffects (path |> App.Router.navigateTo |> Effects.map App.Action.Hop)

            -- Service Actions
            App.Action.Service (App.Action.Retro retroAction) ->
                Retro.Update.update retroAction model.retro
                    |> Response.mapModel (\retro -> { model | retro = retro })
                    |> Response.mapEffects (App.Action.Retro >> App.Action.Service)
            App.Action.Service (App.Action.Id idAction) ->
                Id.Update.update idAction model.id
                    |> Response.mapModel (\id -> { model | id = id })
                    |> Response.mapEffects (App.Action.Id >> App.Action.Service)

            -- Page Actions
            App.Action.Page (App.Action.NoRetroPage createRetro) ->
                model
                    |> Response.withNone
                    :> update (Retro.Action.Create model.id.current |> App.Action.Retro |> App.Action.Service)
                    :> update (Id.Action.Generate |> App.Action.Id |> App.Action.Service)
                    :> update ("/retro/" ++ model.id.current |> App.Action.Navigation)
            App.Action.Page (App.Action.RetroPage addActivity) ->
                model
                    |> Response.withNone
                    :> update (Retro.Action.AddActivity model.id.current |> App.Action.Retro |> App.Action.Service)
                    :> update (Id.Action.Generate |> App.Action.Id |> App.Action.Service)

            _ ->
                model
                    |> Response.withNone


loggedUpdate : AppAction -> AppModel -> AppResponse
loggedUpdate action model =
    let
        action = Debug.log "action" action
        model = Debug.log "model before" model
    in
        Debug.log "model after" (update action model)


router =
    App.Router.createRouter


routerSignal =
    Signal.map App.Action.Route router.signal
