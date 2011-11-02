# Returns the latest news headlines from Google
#
# news - Get the latest headlines
# news <topic> - Get the latest headlines for a specific topic

module.exports = (robot) ->
  robot.respond /news(?: me|on)?\s(.*)/, (msg) ->
    query msg, (body, err) ->
      return msg.send err if err

      strings = []
      
      strings.push "Here's the latest news on that:\n"
      for story in body.responseData.results
        strings.push story.titleNoFormatting

      msg.send strings.join "\n"

  query = (msg, cb) ->
    topic = msg.match[1]
    msg.http("https://ajax.googleapis.com/ajax/services/search/news?v=1.0")
      .query(q: topic)
      .get() (err, res, body) ->
        try
          response = JSON.parse body
        catch err
          err = "Sorry, but I could not fetch latest headlines."
        cb(response, err)
