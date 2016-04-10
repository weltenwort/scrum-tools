module App.Update where

import Debug
import Effects
import Effects.Extra.Infix exposing ((:>))
import Response exposing (Response)

import Activity.Action
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
    case action of
        -- Route Actions
        App.Action.Route (route, _) ->
            {model | route = route}
                |> Response.withNone
        App.Action.Navigation path ->
            model
                |> Response.withEffects
                    (  path
                    |> App.Router.navigateTo
                    |> Effects.map App.Action.Hop
                    )

        -- Service Actions
        App.Action.Service serviceAction ->
            updateService serviceAction model

        -- Page Actions
        App.Action.Page pageAction ->
            updatePage pageAction model

        _ ->
            model
                |> Response.withNone


updateService : App.Action.ServiceAction -> AppModel -> AppResponse
updateService action model =
    case action of
        App.Action.RetroService retroAction ->
            Retro.Update.update retroAction model.retros
                |> Response.mapModel (\retros -> { model | retros = retros })
                |> Response.mapEffects (App.Action.RetroService >> App.Action.Service)

        App.Action.IdService idAction ->
            Id.Update.update idAction model.id
                |> Response.mapModel (\id -> { model | id = id })
                |> Response.mapEffects (App.Action.IdService >> App.Action.Service)

        _ ->
            model
                |> Response.withNone



updatePage : App.Action.PageAction -> AppModel -> AppResponse
updatePage action model =
    case action of
        App.Action.NoRetroPage (Pages.NoRetro.Update.CreateRetro) ->
            model
                |> update
                    (  Retro.Action.Create model.id.current
                    |> App.Action.RetroService
                    |> App.Action.Service
                    )
                :> update
                    (  Id.Action.Generate
                    |> App.Action.IdService
                    |> App.Action.Service
                    )
                :> update
                    (  "/retro/" ++ model.id.current
                    |> App.Action.Navigation
                    )

        App.Action.RetroPage (Pages.Retro.Action.AddActivity retroId) ->
            model
                |> update
                    (  Retro.Action.AddActivity retroId model.id.current
                    |> App.Action.RetroService
                    |> App.Action.Service
                    )
                :> update
                    (  Activity.Action.Create model.id.current
                    |> App.Action.ActivityService
                    |> App.Action.Service
                    )
                :> update
                    (  Id.Action.Generate
                    |> App.Action.IdService
                    |> App.Action.Service
                    )


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
