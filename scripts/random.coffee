# Description:
#   Get 6 Random Numbers for Betting on #Vizon
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot roll - for #Vizon
#
# Author:
#   Jaglag

module.exports = (robot) ->
  robot.respond /(roll)\s?(\d+)?-?(\d+)?/i, (msg) ->
    low  = 1
    high = 29

    if msg.match[3] == undefined && msg.match[2]
      high = parseInt(msg.match[2])
    else if msg.match[2] && msg.match[3]
      low  = parseInt(msg.match[2])
      high = parseInt(msg.match[3])

    rand = (low, high) ->
        Math.floor(Math.random() * (high - low + 1)) + low

    msg.sendPrivate "/notice guuchan !bet #{rand(low, high)} #{rand(low, high)} #{rand(low, high)} #{rand(low, high)} #{rand(low, high)} #{rand(low, high)}"