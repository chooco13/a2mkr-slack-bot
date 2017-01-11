# Description
#   +, -, *, / 계산한 결과를 출력합니다.
#
# Commands:
#   hubot calc <expression> - 사칙연산(+,-,*,/) 계산 결과를 출력합니다.

lexer = (_expr) ->
  `var tokenList`
  expr = _expr
  TOKEN = [
    {
      re: /^(?:\d*\.)?\d+/
      tag: 'NUMBER'
    }
    {
      re: /^\+/
      tag: 'ADD'
    }
    {
      re: /^\-/
      tag: 'SUB'
    }
    {
      re: /^[\*]/
      tag: 'MUL'
    }
    {
      re: /^[\/]/
      tag: 'DIV'
    }
    {
      re: /^[\(]/
      tag: 'LP'
    }
    {
      re: /^[\)]/
      tag: 'RP'
    }
    {
      re: /^[ ]+/
      tag: 'WHITE'
    }
    {
      re: /^$/
      tag: 'EOS'
    }
  ]
  tokenList = []
  i = undefined
  length = TOKEN.length
  matcher = undefined
  literal = undefined
  while expr.length
    i = 0
    while i < length
      matcher = TOKEN[i].re.exec(expr)
      if matcher
        literal = expr.slice(0, matcher[0].length)
        expr = expr.substr(matcher[0].length)
        if TOKEN[i].tag == 'WHITE'
          # pass
        else if TOKEN[i].tag == 'NUMBER'
          tokenList.push
            tag: TOKEN[i].tag
            value: parseFloat(literal)
        else
          tokenList.push
            tag: TOKEN[i].tag
            value: literal
      i++
  tokenList

expr = (tokenList) ->
  value = term(tokenList)
  loop
    if tokenList[0].tag == 'ADD'
      tokenList.shift()
      value += term(tokenList)
    else if tokenList[0].tag == 'SUB'
      tokenList.shift()
      value -= term(tokenList)
    else
      break
  value

term = (tokenList) ->
  value = factor(tokenList)
  if tokenList[0].tag == 'MUL'
    tokenList.shift()
    value *= factor(tokenList)
  else if tokenList[0].tag == 'DIV'
    tokenList.shift()
    value /= factor(tokenList)
  else
  value

factor = (tokenList) ->
  if tokenList[0].tag == 'NUMBER'
    return tokenList.shift().value
  else if tokenList[0].tag == 'LP'
    tokenList.shift()
    value = expr(tokenList)
    if tokenList[0].tag == 'RP'
      tokenList.shift()
    return value
  return

module.exports = (robot) ->
  robot.hear /calc ([0-9.\(\)\+\-\*\/ ]+)/i, (msg) ->
    tokenList = lexer(msg.match[1]);
    result = expr(tokenList);
    msg.send ""+result
