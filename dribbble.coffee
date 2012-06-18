http        = require 'http'
request     = require 'request'
apiBasePath = 'api.dribbble.com'

# --------------------------------------------
# JEFF'S NOTES

# I just made this switch for fun, and to make myself familiar with how data
# flows through the app. It is a bit cleaner though. If you don't like it, feel
# more than free to swap it back out.

# I also added supervisor to reload the app so things are quicker for us in development

# --------------------------------------------

## Simple Helper For Get Requests
# skinnyGetter = (options, cb) ->
#   http.get(options, (res) ->
#     output = ''
#     res.on 'data', (chunk) ->
#       output += chunk
#     res.on 'end', ->
#       cb JSON.parse output
#   ).on 'error', (e) ->
#     throw "error " + e.message
#     cb(
#       'error': e.message
#     )

parseUrl = (url) ->
  if !url then throw "Error: No Url Passed"
  splitUrl = url.split '/'
  return splitUrl[splitUrl.length-1].split('-')[0]

getShotInfo = (id, callback) ->
  request "http://#{apiBasePath}/shots/#{id}", (error, res, body) ->
    if error
      throw "FLAGRANT ERROR! #{error}"
    else
      callback JSON.parse(body)

  # options =
  #   host: apiBasePath
  #   port: 80
  #   path: '/shots/' + id
  # skinnyGetter options, cb

exports.getShotInfo   = getShotInfo
exports.parseUrl      = parseUrl