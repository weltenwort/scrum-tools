module App.Router where

import Hop


type alias RouteParams =
    Hop.Payload


type alias RouteDefinition =
    Hop.RouteDefinition Route


type Route
    = NotFound
    | NoRetro


routes : List RouteDefinition
routes =
    [
    ]


wrapRoute : (Route -> action) -> RouteDefinition -> Hop.RouteDefinition action
wrapRoute wrapper (url, route) =
    (url, wrapper route)


createRouter : (Route -> RouteParams -> action) -> Hop.Router action
createRouter routeAction =
    Hop.new {
        routes = List.map (wrapRoute routeAction) routes,
        notFoundAction = routeAction NotFound
    }
