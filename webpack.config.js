/* eslint-disable no-console */
const webpack = require('webpack');
const merge = require('webpack-merge');
const autoprefixer = require('autoprefixer');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

// detemine build env
const TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'prod' : 'dev';

// common webpack config
const commonConfig = {
  entry: './src/index.js',

  output: {
    path: `${__dirname}/dist`,
    filename: 'bundle.js',
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js'],
  },

  module: {
    loaders: [
      {
        test: /\.js/,
        exclude: [/node_modules/],
        loader: 'babel',
        query: {
          presets: [
            'es2015',
            'react',
          ],
        },
      },
      {
        test: /\.(png|woff|woff2|eot|ttf|svg)$/,
        loader: 'file',
      },
      {
        test: /\.(json)$/,
        loader: 'json',
      },
    ],

    noParse: [
      /socket.io-client\/socket.io.js$/,
    ],
  },

  plugins: [
    new HtmlWebpackPlugin({
      inject: false,
      template: 'node_modules/html-webpack-template/index.ejs',

      appMountId: 'main',
      title: 'Scrum Tools',
      window: {
        env: {
          appMountId: 'main',
        },
      },
    }),
  ],
};

// additional webpack settings for local env (when invoked by 'npm start')
if (TARGET_ENV === 'dev') {
  console.log('Building for development...');

  module.exports = merge(commonConfig, {

    devServer: {
      inline: true,
      stats: 'errors-only',
    },

    module: {
      loaders: [
        {
          test: /\.(css|scss)$/,
          loaders: [
            'style-loader',
            'css-loader',
            'postcss-loader',
            'sass-loader',
          ],
        },
      ],
    },

    postcss: [
      autoprefixer({
        browsers: ['last 2 versions'],
      }),
    ],
  });
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if (TARGET_ENV === 'prod') {
  console.log('Building for production...');

  module.exports = merge(commonConfig, {
    module: {
      loaders: [
        {
          test: /\.(css|scss)$/,
          loader: ExtractTextPlugin.extract('style-loader', [
            'css-loader',
            'postcss-loader',
            'sass-loader',
          ]),
        },
      ],
    },

    postcss: [
      autoprefixer({
        browsers: ['last 2 versions'],
      }),
    ],

    plugins: [
      // extract CSS into a separate file
      new ExtractTextPlugin('./css/stylesheet.css', {
        allChunks: true,
      }),

      // minify & mangle JS/CSS
      new webpack.optimize.UglifyJsPlugin({
        minimize: true,
        compressor: {
          warnings: false,
        },
        mangle: true,
      }),
    ],
  });
}
