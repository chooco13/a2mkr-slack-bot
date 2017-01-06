DAY = 1000 * 60 * 60 * 24

module.exports = (robot) ->
  robot.respond /병역 (.*)$/i, (msg) ->
    name = decodeURIComponent(unescape(msg.match[1]))
    switch(name) # MM/DD/YYYY
      when "종훈", "박종훈" then getRemainDays(msg, new Date("08/01/2018"))
      else msg.send "이름을 다시 확인해주세요."

getRemainDays = (msg, finishDate) ->
  remainDays = Math.round((finishDate.getTime() - new Date()) / DAY)
  msg.send "#{remainDays} 일 남았습니다. 파이팅!"
