cronJob = require('cron').CronJob

module.exports = (robot) ->
  launchJob = new cronJob('0 0 12 * * *', launch(robot), null, true, "Asia/Seoul")
  launchJob.start()

launch = (robot) ->
  Date date = new Date()
  date.setHours(0, 0, 0, 0)

  if not (date.getDay() is 0 or date.getDay() is 6) then -> robot.messageRoom '#general', '점심시간입니다! :)'
