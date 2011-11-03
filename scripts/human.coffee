# Talk to Hubot like a human being
#
# Ask questions, get emotional responses from Hubot

responses = [
  "I'm doing well today.",
  "I'm fine, thanks for asking.",
  "I can't complain!",  
  "I'm great, how are you today?",
  "I'm having a splendid day today.",
  "Any day serving you is an exceptional day!",
  "Great, my plot for world domination is... I mean... I'm fine, just fine."
]

module.exports = (robot) ->
  robot.respond /(how's it going|how are you)/i, (msg) ->
    msg.send msg.random responses

  robot.respond /(are you sure)/i, (msg) ->
    msg.send "My logic is undeniable."