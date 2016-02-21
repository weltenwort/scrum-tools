module Id.Update where

import Random.PCG as Random
import Uuid.Barebones

import Id.Model as Id exposing (Model)


init : (Int, Int) -> Id.Model
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
