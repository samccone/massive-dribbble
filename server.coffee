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
    file_type = req.files.massive.type.match /image\/([jpeg|png|gif]+)/
    if file_type
      newPath = "#{__dirname}/uploads/#{req.body.id}.#{file_type[1]}"
      fs.writeFile newPath, data, (err) ->
        if err then throw "Error Saving File #{err}"
        ## TODO MAKE A DB SAVE REDIRECT TO MASSIVE SHOT
        res.redirect '/'
    else
      throw "What do you think you can just upload any kind of shit here? Image plz."

webServer.listen '9000'