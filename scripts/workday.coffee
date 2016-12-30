DAY = 1000 * 60 * 60 * 24

module.exports = (robot) ->
  robot.respond /근무일 (.*)$/i, (msg) ->
    name = decodeURIComponent(unescape(msg.match[1]))
    switch(name) # MM/DD/YYYY
      when "대현", "황대현" then getWorkDays(msg, new Date("10/10/2016"))
      else msg.send "이름을 다시 확인해주세요."

getWorkDays = (msg, startDate)  ->
  workDays = Math.round((new Date() - startDate.getTime()) / DAY)
  msg.send "#{workDays} 일째 근무중입니다. 파이팅!"