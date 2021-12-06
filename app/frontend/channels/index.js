// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

// include 所有在 _channel 是 js 的檔案
const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)
