http        = require 'http'
apiBasePath = 'api.dribbble.com'

## Simple Helper For Get Requests
skinnyGetter = (options, cb) ->
  http.get(options, (res) ->
    output = ''
    res.on 'data', (chunk) ->
      output += chunk
    res.on 'end', ->
      cb JSON.parse output
  ).on 'error', (e) ->
    throw "error " + e.message
    cb(
      'error': e.message
    )

parseUrl = (url) ->
  if !url then throw "Error No Url Passed"
  splitUrl = url.split '/'
  return splitUrl[splitUrl.length-1].split('-')[0]

getShotInfo = (id, cb) ->
  options =
    host: apiBasePath
    port: 80
    path: '/shots/' + id
  skinnyGetter options, cb

exports.getShotInfo   = getShotInfo
exports.parseUrl      = parseUrl