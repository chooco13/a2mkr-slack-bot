module.exports = (robot) ->
  robot.enter (res) ->
    if res.message.user.room is 'general'
      robot.messageRoom "#general", "#{res.message.user.name} 님이 새로 들어오셨습니다. 안녕하세요 :) 원하시는 채널에서 자유롭게 이야기 해주세요!"