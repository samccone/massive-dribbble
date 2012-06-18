(function() {
  var dribbble, express, fs, webServer;

  express = require('express');

  fs = require('fs');

  dribbble = require('./dribbble');

  webServer = express.createServer();

  webServer.set('view engine', 'jade');

  webServer.use(express.bodyParser());

  webServer.get('/', function(req, res) {
    return res.render('index');
  });

  webServer.post('/shots', function(req, res) {
    return dribbble.getShotInfo(dribbble.parseUrl(req.body.link), function(_data) {
      return res.render('shots/new', {
        data: _data
      });
    });
  });

  webServer.post('/shots/create', function(req, res) {
    return fs.readFile(req.files.massive.path, function(err, data) {
      var newPath;
      newPath = __dirname + '/uploads/' + req.body.id + '.png';
      return fs.writeFile(newPath, data, function(err) {
        if (err) throw "Error Saving File " + err;
        return res.redirect('/');
      });
    });
  });

  webServer.listen('9000');

}).call(this);
