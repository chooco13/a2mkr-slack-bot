weatherURL = 'http://api.openweathermap.org/data/2.5/weather?q='
apiKey = '8b693a3e5f2d1e9bbfc8908514e9d2bd'

# https://openweathermap.org/weather-conditions 참고 (한국어는 정식으로 지원해주지 않음)
# 어색하거나 틀린 것이 있거나 없는 것이 나올 경우 수정할 것
koreanWeatherArray = [
  # Thunderstorm
  {key : 200, value : '뇌우를 동반한 약한 비'},
  {key : 201, value : '뇌우를 동반한 비'},
  {key : 202, value : '뇌우를 동반한 폭우'},
  {key : 210, value : '가벼운 뇌우'},
  {key : 211, value : '뇌우'},
  {key : 212, value : '강한 뇌우'},
  {key : 221, value : '거친 뇌우'},
  {key : 230, value : '뇌우를 동반한 약한 이슬비'},
  {key : 231, value : '뇌우를 동반한 비'},
  {key : 232, value : '뇌우를 동반한 강한 이슬비'},
  
  # Drizzle 
  {key : 300, value : '가벼운 이슬비'},
  {key : 301, value : '이슬비'},
  {key : 302, value : '강한 이슬비'},
  {key : 310, value : ''},
  {key : 311, value : ''},
  {key : 312, value : ''},
  {key : 313, value : ''},
  {key : 314, value : ''},
  {key : 321, value : ''},
  
  # Rain
  {key : 500, value : '가벼운 비'},
  {key : 501, value : '비'},
  {key : 502, value : '강한 비'},
  {key : 503, value : '매우 강한 비'},
  {key : 504, value : ''},
  {key : 511, value : ''},
  {key : 520, value : ''},
  {key : 521, value : ''},
  {key : 522, value : ''},
  {key : 531, value : ''},
  
  # Snow
  {key : 600, value : '가벼운 눈'},
  {key : 601, value : '눈'},
  {key : 602, value : '강한 눈'},
  {key : 611, value : '진눈깨비'},
  {key : 612, value : ''},
  {key : 615, value : '가벼운 비와 눈'},
  {key : 616, value : '비와 눈'},
  {key : 620, value : ''},
  {key : 621, value : ''},
  {key : 622, value : ''},
  
  # Atmosphere
  {key : 701, value : '안개'},
  {key : 711, value : ''},
  {key : 721, value : '안개'},
  {key : 731, value : '모래 및 먼지'},
  {key : 741, value : '안개'},
  {key : 751, value : '모래'},
  {key : 761, value : '먼지'},
  {key : 762, value : '화산재'},
  {key : 771, value : '돌풍'},
  {key : 781, value : '토네이도'},

  # Clear
  {key : 800, value : '맑음'},

  # Clouds
  {key : 801, value : '구름 조금'},
  {key : 802, value : '개임'},
  {key : 803, value : ''},
  {key : 804, value : '흐린 구름'},

  # Extreme
  {key : 900, value : '토네이도'},
  {key : 901, value : '열대 폭풍'},
  {key : 902, value : '허리케인'},
  {key : 903, value : '추움'},
  {key : 904, value : '더움'},
  {key : 905, value : '바람 많음'},
  {key : 906, value : '우박'},

  # Additional
  {key : 951, value : '잔잔함'},
  {key : 952, value : '남실바람'},
  {key : 953, value : '산들바람'},
  {key : 954, value : '건들바람'},
  {key : 955, value : '흔들바람'},
  {key : 956, value : '된바람'},
  {key : 957, value : '폭풍'},
  {key : 958, value : '강풍'},
  {key : 959, value : '강한 강풍'},
  {key : 960, value : '폭풍우'},
  {key : 961, value : '강한 폭풍우'},
  {key : 962, value : '허리케인'},
  ];

koreanWeatherMap = {}
koreanWeatherMap[key] = value for {key, value} in koreanWeatherArray

module.exports = (robot) ->
 robot.hear /날씨/i, (msg) ->	
  weatherFor(msg)

 weatherFor = (msg) ->
  robot.http(weatherURL + 'daejeon' + '&appid=' + apiKey).get() (err, res, body) ->
   json = JSON.parse body
   weatherName = koreanWeatherMap[json.weather[0].id] + "(" + json.weather[0].description + ")"
   
   # 번역되지 않았을 경우 그대로 보여줌
   if weatherName.length is 0 
     weatherName = json.weather[0].description;

   msg.send "현재 날씨는 #{weatherName}, 온도는 #{kelvinToFahrenheit json.main.temp}°C in #{json.name}."

kelvinToFahrenheit = (temp) ->
 ((((temp - 273.15) * 1.8 + 32).toPrecision(2)-32)/1.8).toPrecision(2)
