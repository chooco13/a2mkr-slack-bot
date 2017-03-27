cronJob = require('cron').CronJob
menu=[
  "제육",
  "돈까스",
  "김가네",
  "콩나물국밥",
  "버거킹",
  "낙지볶음",
  "중국식",
  "도시락",
  "찌개",
  "감자탕",
  "초밥",
  "롯데리아",
  "칼국수",
  "막국수"
]
module.exports = (robot) ->
  launchJob = new cronJob('0 0 12 * * *', launch(robot), null, true, "Asia/Seoul")
  launchJob.start()
  #launch = new cronJob('0 0 12 * * *', launchmenu(robot), null, true, "Asia/Seoul")
  #launch.start()
  robot.hear /menu/i, (msg)->
    launchmenu(msg)

launch = (robot) ->
  Date date = new Date()
  date.setHours(0, 0, 0, 0)

  if not (date.getDay() is 0 or date.getDay() is 6) then -> robot.messageRoom '#general', '점심시간입니다! :)'


launchmenu = (msg)->
  i = 0
  count = 3
  upper = menu.length
  resultnumber = []
  result = []
  ball = undefined
  index = undefined
  i = 0
  while i < count
    index = Math.floor(Math.random() * upper)
    if(index in resultnumber)
      continue
    resultnumber.push index
    result.push menu[index]
    i++
  msg.send "#{result}"
  #robot.messageRoom "#general", "추천메뉴는 #{result} 입니다"