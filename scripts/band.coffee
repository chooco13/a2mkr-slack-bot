accessToken = 'ZQAAASxShLTbisoiaYusnkp8gON5q6tebqcRrfzzta5wP3j6aJbTjbSWcwhzjzfwyVCX6EnGTPDsYim-fXnkTmO1NpAv_rUemoHV30NdshPcHS4R';

module.exports = (robot) ->
  robot.hear /밴드/i, (msg)->
    crawling(robot)

crawling = (robot) ->
  robot.http('https://openapi.band.us/v2/band/posts?band_key=AACGljlMZOsOSd6mvm-q_HVx').header('Authorization', 'Bearer ' + accessToken).get() (err, res, body) ->
    json = JSON.parse body
    message = ''

    json.result_data.items.forEach (item, i) ->
      message += new Date(item.created_at).toISOString() + "\n"
      message += item.content + '\n\n'

    robot.messageRoom '#si03', message
