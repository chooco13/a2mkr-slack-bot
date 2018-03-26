moment = require('moment');
moment.locale('ko')

appKey = 'c72c7393-6813-4f93-971d-9b57b20e6dd6';
weatherURL = 'http://api2.sktelecom.com/weather/current/hourly?lon=127.42&village=&county=&lat=36.32&city=&version=1';
wctIndexURL = 'http://api2.sktelecom.com/weather/windex/wctindex?lon=127.42&lat=36.32&version=1'
dailyURL = 'http://api2.sktelecom.com/weather/summary?lon=127.42&village=&county=&foretxt=&lat=36.32&city=&version=1';

module.exports = (robot) ->
  robot.hear /날씨/i, (msg) ->
    weatherFor(msg)

  robot.hear /나알씨이/i, (msg) ->
    getDailyWeather(msg)

  weatherFor = (msg) ->
    message  = ''

    robot.http(weatherURL).header('appKey', appKey).get() (err, res, body) ->
      json = JSON.parse body

      weather = json.weather.hourly[0];

      message = "대전의 현재 날씨는 '" + weather.sky.name + "' 입니다.\n\n";

      message += '기온는 ' + Math.round(weather.temperature.tc) + '°C 입니다.\n';
      message += '습도는 ' + Math.round(weather.humidity) + '% 입니다.\n\n'

      msg.send message


  getDailyWeather = (msg) ->
    robot.http(dailyURL).header('appKey', appKey).get() (err, res, body) ->
      json = JSON.parse body

      message = '내일 모래까지의 대전 날씨!\n\n';

      now = moment();

      summary = json.weather.summary[0];

      today = summary.today;
      tomorrow = summary.tomorrow;
      dayAfterTomorrow = summary.dayAfterTomorrow;

      message += now.format('MM월 DD일 (ddd)') + '\n';
      message += '날씨 : ' + today.sky.name + '\n';
      message += '최저 : ' + Math.round(today.temperature.tmin) + '°C\n';
      message += '최고 : ' + Math.round(today.temperature.tmax) + '°C\n\n';

      message += now.add('days', 1).format('MM월 DD일 (ddd)') + '\n';
      message += '날씨 : ' + tomorrow.sky.name + '\n';
      message += '최저 : ' + Math.round(tomorrow.temperature.tmin) + '°C\n';
      message += '최고 : ' + Math.round(tomorrow.temperature.tmax) + '°C\n\n';

      message += now.add('days', 1).format('MM월 DD일 (ddd)') + '\n';
      message += '날씨 : ' + dayAfterTomorrow.sky.name + '\n';
      message += '최저 : ' + Math.round(dayAfterTomorrow.temperature.tmin) + '°C\n';
      message += '최고 : ' + Math.round(dayAfterTomorrow.temperature.tmax) + '°C\n\n';

      message = message.trim();

      msg.send message
