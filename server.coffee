express   = require 'express'
fs        = require 'fs'
dribbble  = require './dribbble'
webServer = express.createServer()

webServer.set 'view engine', 'jade'
webServer.use express.bodyParser()

webServer.get '/', (req, res) ->
  res.render 'index'

webServer.post '/shots', (req, res) ->
  dribbble.getShotInfo(dribbble.parseUrl(req.body.link), (_data) ->
    res.render 'shots/new',
      data: _data
  )

webServer.post '/shots/create', (req, res) ->
  fs.readFile req.files.massive.path, (err, data) ->
    ## TODO MAKE THIS SAVE THE RIGHT FILE TYPE
    newPath = __dirname + '/uploads/' + req.body.id + '.png'
    fs.writeFile newPath, data, (err) ->
      if err then throw "Error Sacing File " + err
      ## TODO MAKE A DB SAVE REDIRECT TO MASSIVE SHOT
      res.redirect '/'

webServer.listen '9000'