module App.Action where

import Activity.Action
import Pages.NoRetro.Update
import Pages.Retro.Action
import Id.Action
import Retro.Action
import App.Router


type ServiceAction
    = RetroService Retro.Action.Action
    | IdService Id.Action.Action
    | ActivityService Activity.Action.Action

type PageAction
    = NoRetroPage Pages.NoRetro.Update.Action
    | RetroPage Pages.Retro.Action.Action

type Action
    = NoOp
    | Route (App.Router.Route, App.Router.Location)
    | Navigation String
    | Hop ()
    | Service ServiceAction
    | Page PageAction
