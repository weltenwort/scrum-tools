module Retro.Action where

import Retro.Model


type Action
    = NoOp
    | Create Retro.Model.Id
    | AddActivity Retro.Model.Id String
