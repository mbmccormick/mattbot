# Talk to Hubot like a human being
#
# Ask questions, get emotional responses from Hubot

feelings = [
  "I'm doing well today.",
  "I'm fine, thanks for asking.",
  "I can't complain!",  
  "I'm great, how are you today?",
  "I'm having a splendid day today.",
  "Any day serving you is an exceptional day!",
  "Great, my plot for world domination is... I mean... I'm fine, just fine."
]

manners = [
  "You're welcome.",
  "No problem.",
  "Anytime.",
  "That's what I'm here for!",
  "You are more than welcome.",
  "You don't have to thank me, I'm your loyal servant.",
  "Don't mention it."
]

module.exports = (robot) ->
  robot.respond /(how are you|how's it going|hows it going|how is it going|how's your day|hows your day|how is your day|how goes it)/i, (msg) ->
    msg.send msg.random feelings

  robot.respond /(thanks|thank you|cheers|nice one)/i, (msg) ->
    msg.send msg.random manners
  
  robot.respond /(are you sure)/i, (msg) ->
    msg.send "My logic is undeniable."
