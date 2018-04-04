cronJob = require('cron').CronJob

http = require("http");
setInterval (->
  http.get 'https://a2mkr-slack-bot.herokuapp.com/'
  console.log 'wake up!'
  return
), 300000

module.exports = (robot) ->
  leaveJob = new cronJob('0 0 18 * * *', leave(robot), null, true, "Asia/Seoul")
  leaveJob.start()
  workJob = new cronJob('0 50 8 * * *', work(robot), null, true, "Asia/Seoul")
  workJob.start()

leave = (robot) ->
  Date date = new Date()
  date.setHours(0, 0, 0, 0)

  if not (date.getDay() is 0 or date.getDay() is 6) then -> robot.messageRoom '#general', '퇴근할 시간입시다! 오늘 하루도 수고하셨습니다 :)'

work = (robot) ->
  Date date = new Date()
  date.setHours(0, 0, 0, 0)
  
  if not (date.getDay() is 0 or date.getDay() is 6) then -> robot.messageRoom '#general', '9시 10분 전 입니다! 출근 도장 꼭 찍으세요! 오늘도 파이팅! :)'
