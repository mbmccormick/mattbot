# Returns weather information from Google
#
# weather <city> - Get the weather for a location
# forecast <city> - Get the forecast for a location
JsDom = require 'jsdom';

module.exports = (robot) ->
  robot.respond /forecast(?: me)?\s(.*)/, (msg) ->
    query msg, (body, err) ->
      return msg.send err if err;

      city = body.getElementsByTagName("city")[0];
      return msg.send "Sorry, but you didn't specify a location." if not city or not city.getAttribute;
      
      city = city.getAttribute("data");

      strings = []
      
      strings.push "The forecast for #{city} is as follows:";      
      for element in body.getElementsByTagName("forecast_conditions")
        day = element.getElementsByTagName("day_of_week")[0].getAttribute("data");
        if env.HUBOT_WEATHER_CELCIUS
          low = convertTempToCelcius(element.getElementsByTagName("low")[0].getAttribute("data")) + "ºC";
        else
          low = element.getElementsByTagName("low")[0].getAttribute("data") + "ºF";
        if env.HUBOT_WEATHER_CELCIUS
          high = convertTempToCelcius(element.getElementsByTagName("high")[0].getAttribute("data")) + "ºC";
        else
          high = element.getElementsByTagName("high")[0].getAttribute("data") + "ºF";
        condition = element.getElementsByTagName("condition")[0].getAttribute("data");
        strings.push "#{day}: #{condition} with a high of #{high} and a low of #{low}.";

      msg.send strings.join "\n";

  robot.respond /weather(?: me)?\s(.*)/, (msg) ->
    query msg, (body, err) ->
      return msg.send err if err;

      city = body.getElementsByTagName("city")[0];
      return msg.send "Sorry, but you didn't specify a location." if not city or not city.getAttribute;
      
      city = city.getAttribute("data");
      currentCondition = body.getElementsByTagName("current_conditions")[0].getAttribute("data");
      conditions = currentCondition.getElementsByTagName("condition")[0].getAttribute("data").toLowerCase();
      humidity = currentCondition.getElementsByTagName("humidity")[0].getAttribute("data").split(' ')[1];

      if env.HUBOT_WEATHER_CELCIUS
        temp = currentCondition.getElementsByTagName("temp_c")[0].getAttribute("data") + "ºC";
      else
        temp = currentCondition.getElementsByTagName("temp_f")[0].getAttribute("data") + "ºF";
      
      msg.send "Currently in #{city} it is #{conditions} and #{temp} with a humidity of #{humidity}.\n";

  getDom = (xml) ->
    body = JsDom.jsdom(xml);
    throw Error("No XML data returned.") if body.getElementsByTagName("weather")[0].childNodes.length == 0;
    body;

  convertTempToCelcius = (f) ->
    ((5 / 9) * (f - 32)).toFixed 0;

  query = (msg, cb) ->
    location = msg.match[1];
    msg.http("http://www.google.com/ig/api")
      .query(weather: location)
      .get() (err, res, body) ->
        try
          body = getDom body;
        catch err
          err = "Could not fetch weather data.";
        cb(body, err);
