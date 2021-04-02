const webpack = require("webpack");

module.exports = {
  publicPath: process.env.BASE_URL,
  devServer: {
    port: 3000,
  },
  configureWebpack: {
    plugins: [
      new webpack.ProvidePlugin({
        $: "jquery",
        jquery: "jquery",
        "window.jQuery": "jquery",
        jQuery: "jquery",
      }),
    ],
  },
};
