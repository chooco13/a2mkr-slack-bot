# Description
#   로또 번호를 무작위로 생성합니다.
#
# Commands:
#   hubot lotto - 로또 번호를 무작위로 생성합니다.
getLottery = (msg) ->
  i = 0
  count = 6
  marks = []
  bag = []
  upper = 45
  result = []
  i = 1
  while i < 46
    bag.push i
    i++
  ball = undefined
  index = undefined
  i = 0
  while i < count
    index = Math.floor(Math.random() * upper)
    ball = bag[index]
    bag[index] = bag[upper - 1]
    marks.push ball
    upper -= 1
    i++
  marks.sort (x, y) ->
    x - y

  msg.send "#{marks}"

module.exports = (robot) ->
  robot.hear /로또/i, (msg) ->
    getLottery(msg)
