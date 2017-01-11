weatherURL = 'http://api.openweathermap.org/data/2.5/weather?q='
apiKey = '8b693a3e5f2d1e9bbfc8908514e9d2bd'
	
module.exports = (robot) ->
 robot.hear /날씨/i, (msg) ->	
  weatherFor(msg)

 weatherFor = (msg) ->
  robot.http(weatherURL + 'daejeon' + '&appid=' + apiKey).get() (err, res, body) ->
   json = JSON.parse body
   msg.send "현재 날씨는 #{json.weather[0].main}(#{json.weather[0].description}) 온도는 #{kelvinToFahrenheit json.main.temp}°C in #{json.name}."

kelvinToFahrenheit = (temp) ->
 ((((temp - 273.15) * 1.8 + 32).toPrecision(2)-32)/1.8).toPrecision(2)
