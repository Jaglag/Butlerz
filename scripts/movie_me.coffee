# Description:
#   Movie database lookups
#
# Dependencies:
#   "cheerio": "0.10.7",
#   "request": "2.14.0"
#
# Configuration:
#   None
#
# Commands:
#   Hubot movie me <title> - look up a movie on IMDB
#
# Author:
#   gpspake
#   dpritchett

request = require 'request'
cheerio = require 'cheerio'
url     = "http://www.omdbapi.com/?t="

module.exports = (robot) ->
  
  robot.respond /(movie|imdb|omdb)( me)? (.*)/i, (msg) ->
    title = msg.match[3]
    request "#{url + title}", (error, response, body)->
      deets = JSON.parse body

      if deets.Title
        output = "#{deets.Title}, #{deets.Year}, Released: #{deets.Released}, imdbRating: #{deets.imdbRating}, Metascore: #{deets.Metascore}, Genre: #{deets.Genre}. Plot: #{deets.Plot}  Imdb:"
        if deets.imdbID?
          output += " http://www.imdb.com/title/#{deets.imdbID}"
      else
        output = "Movie not found."

      msg.send output
