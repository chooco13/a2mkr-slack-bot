request = require 'request'

module.exports = (robot) ->
    robot.respond /날씨.*/i, (msg) ->
      msg.send('테스트')
