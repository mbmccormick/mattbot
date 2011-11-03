# Talk to Hubot like a human being
#
# Ask questions, get emotional responses from Hubot

greetings = [
  "Hello, how are you doing?",
  "Hey there!",
  "Howdy! How are you today?",  
  "Hello!",
  "Why, hello! How are you?",
  "Hi!",
  "Hey!"
]

salutations = [
  "Goodbye!",
  "Bye, have a nice day!",
  "See you later!",  
  "Bye!",
  "Goodbye, enjoy your day!",
  "Come back soon!",
  "Have a great day! Bye!"
]

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
  robot.respond /(hello|howdy|good morning|good afternoon|hi|hey)/i, (msg) ->
    msg.send msg.random greetings
    
  robot.respond /(bye|see ya|see you later|adios|goodbye|goodnight)/i, (msg) ->
    msg.send msg.random salutations
  
  robot.respond /(.*)?(how are you|how's it going|hows it going|how is it going|how's your day|hows your day|how is your day|how goes it)/i, (msg) ->
    msg.send msg.random feelings

  robot.respond /(.*)?(thanks|thank you|cheers|nice one)/i, (msg) ->
    msg.send msg.random manners
  
  robot.respond /(.*)?(are you sure)/i, (msg) ->
    msg.send "My logic is undeniable."
