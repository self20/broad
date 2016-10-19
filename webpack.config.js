var ExtractTextPlugin = require('extract-text-webpack-plugin');
var webpack = require('webpack');

module.exports = {
  entry: {
    main: ['./app/react/index.js']
  },
  output: {
    path: __dirname + '/app/assets/javascripts',
    filename: 'react_bundle.js'
  },
  module: {
    loaders: [
      {
        key: 'jsx',
        test: /\.jsx?$/,
        exclude: /(node_modules)/,
        loaders: ['babel']
      },
      {
        key: 'style',
        test: /\.s?css$/,
        loader: ExtractTextPlugin.extract('css!sass')
      }
    ]
  },
  resolve: {
    extensions: ['', '.js', '.jsx', '.js.jsx']
  },
  plugins: [
    new ExtractTextPlugin('../stylesheets/react_bundle.css', {
      allChunks: true
    }),
    new webpack.DefinePlugin({
      'process.env':{
        'NODE_ENV': JSON.stringify('production')
      }
    }),
    new webpack.optimize.UglifyJsPlugin({
      compress:{
        warnings: true
      }
    })
  ]
};
