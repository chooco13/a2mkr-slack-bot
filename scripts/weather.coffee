request = require 'request'

module.exports = (robot) ->
	robot.respond /날씨 (.*)$/i, (msg) ->

	request 'http://api.openweathermap.org/data/2.5/weather?lat=37.5666386&lon=126.977948&appid=8b693a3e5f2d1e9bbfc8908514e9d2bd',(error, res, body) ->
		json = JSON.parse body
		todayWeather = json['main'][0]
		location = json['name'][0]
		Temp = todayWeather['temp']
		msg.send '지역은 '+location+'입니다. 현재 온도는' + Temp + '℃입니다.'

