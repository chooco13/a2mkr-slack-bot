module.exports = (robot) ->
  robot.enter (res) ->
    # res.message.user.room 이 channel의 id 값을 리턴함
    # https://api.slack.com/methods/channels.list/test 에서 확인 가능

    if res.message.user.room is 'C3JL36LQ3' #general
      robot.messageRoom "#general", "#{res.message.user.name} 님이 새로 들어오셨습니다. 안녕하세요 :) 원하시는 채널에서 자유롭게 이야기 해주세요!"