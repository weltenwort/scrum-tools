var webpack           = require( 'webpack' );
var merge             = require( 'webpack-merge' );
var autoprefixer      = require( 'autoprefixer' );
var ExtractTextPlugin = require( 'extract-text-webpack-plugin' );
var HtmlWebpackPlugin = require('html-webpack-plugin');

// detemine build env
var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'prod' : 'dev';

// common webpack config
var commonConfig = {
  entry: './src/index.js',

  output: {
    path:     __dirname + '/dist',
    filename: 'bundle.js'
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions:         ['', '.js', '.elm']
  },

  module: {
    loaders: [
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack'
      },
      {
        test: /\.(png|woff|woff2|eot|ttf|svg)$/,
        loader: 'file'
      },
      {
        test: /\.(json)$/,
        loader: 'json'
      }
    ],

    noParse: [
        /\.elm$/,
        /socket.io-client\/socket.io.js$/
    ]
  },

  plugins: [
    new HtmlWebpackPlugin({
      inject: false,
      template: 'node_modules/html-webpack-template/index.ejs',

      appMountId: 'main',
      title: 'Scrum Tools',
      window: {
        env: {
          elmMountId: 'main'
        }
      }
    })
  ]
}

// additional webpack settings for local env (when invoked by 'npm start')
if ( TARGET_ENV === 'dev' ) {
  console.log( 'Building for development...');

  module.exports = merge( commonConfig, {

    devServer: {
      inline: true,
      stats: 'errors-only'
    },

    module: {
      loaders: [
        {
          test: /\.(css|scss)$/,
          loaders: [
            'style-loader',
            'css-loader',
            'postcss-loader',
            'sass-loader'
          ]
        }
      ]
    },

    postcss: [ autoprefixer( { browsers: ['last 2 versions'] } ) ]
    
  });
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if ( TARGET_ENV === 'prod' ) {
  console.log( 'Building for production...');

  module.exports = merge( commonConfig, {
    module: {
      loaders: [
        {
          test: /\.(css|scss)$/,
          loader: ExtractTextPlugin.extract( 'style-loader', [
            'css-loader',
            'postcss-loader',
            'sass-loader'
          ])
        }
      ]
    },

    postcss: [ autoprefixer( { browsers: ['last 2 versions'] } ) ],

    plugins: [
      // extract CSS into a separate file
      new ExtractTextPlugin( './css/stylesheet.css', { allChunks: true } ),

      // minify & mangle JS/CSS
      new webpack.optimize.UglifyJsPlugin({
          minimize:   true,
          compressor: { warnings: false },
          mangle:     true                      // TODO: need any exceptions?
      })
    ]

  });
}
