// Main entrypoint file
require( '../dist/index.html' );

// pull in desired CSS/SASS files
require( './styles/app.css' );

var Elm = require( './Main' );
var target = document.getElementById('main');
var staticPortValues = {
    randomSeed: [
        Math.floor(Math.random()*0xFFFFFFFF),
        Math.floor(Math.random()*0xFFFFFFFF)
    ]
};
Elm.embed(Elm.Main, target, staticPortValues);
