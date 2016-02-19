import Effects
import Html
import StartApp
import Task


type Action = Nothing
type alias Model = {}


view : Signal.Address Action -> Model -> Html.Html
view address model =
    Html.div
        []
        []


init : (Model, Effects.Effects Action)
init =
    ({}, Effects.none)


update : Action -> Model -> (Model, Effects.Effects Action)
update action model =
    (model, Effects.none)


app : StartApp.App Model
app =
    StartApp.start
        { init = init
        , inputs = []
        , update = update
        , view = view
        }


main : Signal.Signal Html.Html
main =
    app.html


port runner : Signal (Task.Task Effects.Never ())
port runner =
    app.tasks
