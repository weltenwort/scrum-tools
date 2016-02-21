import Effects
import Html
import StartApp
import Task

import App.Model
import App.Update
import App.View


app : StartApp.App App.Model.Model
app =
    StartApp.start
        { init = App.Update.init
        , inputs = []
        , update = App.Update.update
        , view = App.View.view
        }


main : Signal.Signal Html.Html
main =
    app.html


port runner : Signal (Task.Task Effects.Never ())
port runner =
    app.tasks
