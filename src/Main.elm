import Effects
import Html
import StartApp
import Task

import App.Model
import App.Update exposing (router)
import App.View


app : StartApp.App App.Model.Model
app =
    StartApp.start
        { init = App.Update.init randomSeed
        , inputs = [router.signal]
        , update = App.Update.update
        , view = App.View.view
        }


main : Signal.Signal Html.Html
main =
    app.html


port runner : Signal (Task.Task Effects.Never ())
port runner =
    app.tasks


port randomSeed : (Int, Int)


port routeRunTask : Task.Task () ()
port routeRunTask =
    router.run
