module App.Model where

import Activity.Model
import App.Router
import Id.Model
import Retro.Model


type alias Model =
    { activities : Activity.Model.Collection
    , id : Id.Model.Model
    , retros : Retro.Model.Collection
    , route : App.Router.Route
    }


initial : Model
initial =
    { activities = Activity.Model.initialCollection 
    , id = Id.Model.initialModel
    , retros = Retro.Model.initialCollection
    , route = App.Router.NotFound
    }
