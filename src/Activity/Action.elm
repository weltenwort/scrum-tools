module Activity.Action where

import Activity.Model


type Action
    = NoOp
    | Create Activity.Model.Id
