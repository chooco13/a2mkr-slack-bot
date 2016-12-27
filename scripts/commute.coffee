cronJob = require('cron').CronJob

module.exports = (robot) ->
  leaveJob = new cronJob('0 0 18 * * *', leave(robot), null, true, "Asia/Seoul")
  leaveJob.start()
  workJob = new cronJob('0 50 8 * * *', work(robot), null, true, "Asia/Seoul")
  workJob.start()

leave = (robot) ->
  -> robot.messageRoom '#general', '퇴근할 시간입시다! 오늘 하루도 수고하셨습니다 :)'

work = (robot) ->
  -> robot.messageRoom '#general', '9시 10분 전 입니다! 출근 도장 꼭 찍으세요! :)'
