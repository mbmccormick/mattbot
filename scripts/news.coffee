# Returns the latest news headlines from Google
#
# news - Get the latest headlines
# news <topic> - Get the latest headlines for a specific topic

module.exports = (robot) ->
  robot.respond /news(?: me|on)?\s(.*)/, (msg) ->
    query msg, (body, err, topic) ->
      return msg.send err if err

      strings = []
      
      strings.push "Here's the latest news on #{topic}:\n"
      for story in body.responseData.results
        strings.push story.titleNoFormatting.replace("&#39;", "'")

      msg.send strings.join "\n"

  query = (msg, cb) ->
    topic = msg.match[1]
    msg.http("https://ajax.googleapis.com/ajax/services/search/news?v=1.0&rsz=5")
      .query(q: topic)
      .get() (err, res, body) ->
        try
          response = JSON.parse body
        catch err
          err = "Sorry, but I could not fetch latest headlines."
        cb(response, err, topic)
