module App.Update where

import Debug
import Effects exposing (Effects)

import App.Action
import App.Model
import App.Router
import Id.Action
import Id.Update


init : (Int, Int) -> (App.Model, Effects Action)
init randomSeed =
    let
        initialId = Id.Update.init randomSeed
        initialModel = App.Model.initial
        model = { initialModel
            | id = initialId
        }
    in
        ( model
        , Effects.none
        )


update : Action -> App.Model -> (App.Model, Effects Action)
update action model =
    case action of
        ShowRoute route _ ->
            ( {model | route = route}
            , Effects.none
            )
        App.Action.Service (App.Action.Id idAction) ->
            Id.Update.update idAction model.id
                |> Response.mapModel (\id -> { model | id = id })
                |> Response.mapEffects (App.Action.Id >> App.Action.Service)
        _ ->
            ( model
            , Effects.none
            )


loggedUpdate : Action -> App.Model -> (App.Model, Effects Action)
loggedUpdate action model =
    let
        action = Debug.log "action" action
        model = Debug.log "model before" model
    in
        Debug.log "model after" (update action model)


router =
    App.createRouter ShowRoute
