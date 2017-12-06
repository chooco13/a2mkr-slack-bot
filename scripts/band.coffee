cronJob = require('cron').CronJob

admin = require("firebase-admin");

# in local
#serviceAccount = require("../slack-499dc-firebase-adminsdk-aq6v9-465f1538bc.json");
#admin.initializeApp({
#  credential: admin.credential.cert(serviceAccount),
#  databaseURL: "https://slack-499dc.firebaseio.com/"
#});

# in server
admin.initializeApp({
  credential: admin.credential.cert({
      "type": "service_account",
      "project_id": "slack-499dc",
      "private_key_id": process.env.private_key_id,
      "private_key": process.env.private_key,
      "client_email": process.env.client_email,
      "client_id": process.env.client_id,
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://accounts.google.com/o/oauth2/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": process.env.client_x509_cert_url
    }),
  databaseURL: "https://slack-499dc.firebaseio.com/"
});

db = admin.database();
ref = db.ref("band");

accessToken = 'ZQAAASxShLTbisoiaYusnkp8gON5q6tebqcRrfzzta5wP3j6aJbTjbSWcwhzjzfwyVCX6EnGTPDsYim-fXnkTmO1NpAv_rUemoHV30NdshPcHS4R';

module.exports = (robot) ->
  robot.hear /밴드/i, (msg)->
    crawling(robot)
  crawlingJob = new cronJob('0 0 * * * *', crawlingCron(robot), null, true, "Asia/Seoul")
  crawlingJob.start()

crawlingCron = (robot) ->
  -> crawling(robot)

crawling = (robot) ->
  robot.http('https://openapi.band.us/v2/band/posts?band_key=AACGljlMZOsOSd6mvm-q_HVx').header('Authorization', 'Bearer ' + accessToken).get() (err, res, body) ->
    json = JSON.parse body
    json.result_data.items.forEach (item, i) ->
      ref.once 'value', (snap) ->
        if not snap.hasChild(item.post_key)
          ref.child(item.post_key).set(true)
          robot.messageRoom '#si03', item.content
