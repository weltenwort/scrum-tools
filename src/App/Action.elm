module App.Action where

import Pages.NoRetro.Update
import Id.Action
import Retro.Action
import App.Router


type ServiceAction
    = Retro Retro.Action.Action
    | Id Id.Action.Action

type PageAction
    = NoRetro Pages.NoRetro.Update.Action

type Action
    = NoOp
    | Route (App.Router.Route, App.Router.Location)
    | Navigation String
    | Hop ()
    | Service ServiceAction
    | Page PageAction
