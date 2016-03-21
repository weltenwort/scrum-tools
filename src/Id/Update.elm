module Id.Update where

import Random.PCG as Random
import Response exposing (Response)
import Uuid.Barebones

import Id.Action
import Id.Model


type alias IdAction = Id.Action.Action
type alias IdModel = Id.Model.Model
type alias IdResponse = Response IdModel IdAction


update : IdAction -> IdModel -> IdResponse
update action model =
    case action of
        Id.Action.Generate ->
            let
                (nextId, nextSeed) = generate model.seed
            in
                { model
                | current = nextId
                , seed = nextSeed
                }
                    |> Response.withNone


init : (Int, Int) -> Id.Model.Model
init randomSeed =
    let
        (nextId, nextSeed) = randomSeed
            |> uncurry Random.initialSeed2
            |> generate
    in
        { current = nextId
        , seed = nextSeed
        }


generate : Random.Seed -> (String, Random.Seed)
generate =
    Random.generate Uuid.Barebones.uuidStringGenerator
