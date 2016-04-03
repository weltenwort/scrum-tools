const webpack = require('webpack');
const webpackMiddleware = require('webpack-dev-middleware');

const webpackConfig = require('../webpack.config.js');


const createMiddleware = () => webpackMiddleware(
    webpack(webpackConfig),
    {
        stats: false
    }
);


module.exports = createMiddleware;
