DAY = 1000 * 60 * 60 * 24

cronJob = require('cron').CronJob

module.exports = (robot) ->
  paydayJob = new cronJob('0 0 9 * * *', payday(robot), null, true, "Asia/Seoul")
  paydayJob.start()

payday = (robot) ->
  today = new Date()
  today.setHours(0, 0, 0, 0)
  
  if today.getMonth() + 1 is 12
    payday = new Date(today.getFullYear() + 1, 0, 1)
  else
    payday = new Date(today.getFullYear(), today.getMonth() + 1, 1)

  if payday.getDay() is 0
    payday = new Date(payday - DAY * 2) 
  else if payday.getDay() is 6
    payday = new Date(payday - DAY)

  if today.getTime() == payday.getTime() 
    -> robot.messageRoom '#general', "오늘은 월급날 입니다. 한달동안 수고많으셨고 즐거운 하루 되세요! :)"
  else
    -> robot.messageRoom '#general', "#{today} #{payday} #{today.getDay()} #{payday.getDay()}"