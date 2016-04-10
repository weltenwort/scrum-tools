require( './styles/app.css' );

var Elm = require( './Main' );
var target = document.getElementById(env.elmMountId);
var staticPortValues = {
    randomSeed: [
        Math.floor(Math.random()*0xFFFFFFFF),
        Math.floor(Math.random()*0xFFFFFFFF)
    ]
};
Elm.embed(Elm.Main, target, staticPortValues);
