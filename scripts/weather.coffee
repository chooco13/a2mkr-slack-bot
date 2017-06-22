moment = require('moment');

weatherURL = 'http://api.openweathermap.org/data/2.5/weather?q=daejeon&appid=8b693a3e5f2d1e9bbfc8908514e9d2bd&lang=kr&units=metric'
dailyURL = 'http://api.openweathermap.org/data/2.5/forecast/daily?q=daejeon&appid=8b693a3e5f2d1e9bbfc8908514e9d2bd&lang=kr&units=metric';

module.exports = (robot) ->
  robot.hear /날씨/i, (msg) ->
    weatherFor(msg)

  robot.hear /나알씨이/i, (msg) ->
    getDailyWeather(msg)

  weatherFor = (msg) ->
    robot.http(weatherURL).get() (err, res, body) ->
      json = JSON.parse body

      weather = json.weather[0].description + "(" + json.weather[0].main + ")";

      msg.send "현재 대전 날씨는 #{weather}입니다. 기온는 #{Math.round(json.main.temp)}°C 입니다."


  getDailyWeather = (msg) ->
    robot.http(dailyURL).get() (err, res, body) ->
      json = JSON.parse body

      message = '';

      message += json.list.length + ' 일 동안의 대전 날씨!\n\n';

      json.list.forEach (daily) ->
        weather = daily.weather[0].description + '(' + daily.weather[0].main + ')';

        message += moment.unix(daily.dt).format('MM월 DD일') + '\n';
        message += '날씨 : ' + weather + '\n';
        message += '최저 : ' + daily.temp.min + '°C\n';
        message += '최고 : ' + daily.temp.max + '°C\n';

        message += '\n';

      message = message.trim();

      msg.send message