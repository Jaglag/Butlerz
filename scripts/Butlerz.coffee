# Description:
#   Butlerz Utility Belt
#   For everything else that don't belong...
#
# Dependencies:
#   "moment": "^2.8.3"
#
# Configuration:
#   HUBOT_AUTH_ADMIN - A comma separate list of user IDs
#
# Commands:
#   Hubot delete <key> - Removes <key> and all of its content from the local brain / persistence
#   hubot math <question> - query Wolfram Alpha
#
# Author:
#   MrSaints
#
# Notes:
#   * TODO: Brain save wrapper? / Dirty-checking -> Save
#
# URLS:
#   GET /

moment = require 'moment'
adminOnly = [
    'repeat'
    'brain save'
    'die'
    'adme'
    'reload all scripts'
    'show storage'
    'show users'
    'fake event'
    'wipe (.+)'
    'kitten bomb me(.+)'
    'Ping'
    'rss add (.+)'
    'rss delete (.+)'
]

module.exports = (robot) ->
    start = moment()

    robot.router.get '/', (req, res) ->
        res.send "I am <a href=\"https://github.com/Jaglag/Butler\">Butlerz</a>, the bot and I have been sentient since #{start.fromNow()}."

    # Restrict commands
    if process.env.HUBOT_AUTH_ADMIN?
        admins = process.env.HUBOT_AUTH_ADMIN.split ','

        robot.respond /(.*)/i, (msg) ->
            return unless msg.match[1]

            userCommand = msg.match[1]
            matches = adminOnly.filter (command) ->
                userCommand.match new RegExp(command, 'i')

            if matches.length > 0 and msg.message.user.id.toString() not in admins
                msg.message.done = true
                msg.reply "Sorry, the command you have entered has been restricted to admins only."

    robot.respond /wipe (.*)/i, (msg) ->
        key = msg.match[1]

        unless robot.brain.data[key]?
            msg.reply "The key you have entered (\"#{key}\") does not exist."
            return

        delete robot.brain.data[key]
        msg.reply "\"#{key}\" and all of its contents have been wiped from the brain."

