module.exports = (robot) ->
    robot.respond / (.*)$/i, (msg) ->
        msg.send "테스트입니다"
