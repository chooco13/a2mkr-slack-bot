DAY = 1000 * 60 * 60 * 24

cronJob = require('cron').CronJob

module.exports = (robot) ->
  paydayJob = new cronJob('0 0 9 * * *', payday(robot), null, true, "Asia/Seoul")
  paydayJob.start()

payday = (robot) ->
  today = new Date()
  today.setHours(0, 0, 0, 0)
  
  # 다음달 첫 일을 찾음.
  if today.getMonth() + 1 is 12
    payday = new Date(today.getFullYear() + 1, 0, 1)
  else
    payday = new Date(today.getFullYear(), today.getMonth() + 1, 1)

  # 다음달 첫 일에서 하루를 빼서 이번달 마지막 일 찾음
  payday = new Date(payday - DAY)

  # 이번달 마지막 일이 일요일이거나 토요일일 경우 금요일을 가져오도록 처리
  if payday.getDay() is 0
    payday = new Date(payday - DAY * 2) 
  else if payday.getDay() is 6
    payday = new Date(payday - DAY)

  # 오늘이 월급일 일경우 메시지를 띄워줌
  if today.getTime() is payday.getTime() 
    -> robot.messageRoom '#general', "오늘은 월급날 입니다. 한달동안 수고많으셨고 즐거운 하루 되세요! :)"
