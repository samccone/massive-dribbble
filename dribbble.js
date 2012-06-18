(function() {
  var apiBasePath, getShotInfo, http, parseUrl, skinnyGetter;

  http = require('http');

  apiBasePath = 'api.dribbble.com';

  skinnyGetter = function(options, cb) {
    return http.get(options, function(res) {
      var output;
      output = '';
      res.on('data', function(chunk) {
        return output += chunk;
      });
      return res.on('end', function() {
        return cb(JSON.parse(output));
      });
    }).on('error', function(e) {
      throw "error " + e.message;
      return cb({
        'error': e.message
      });
    });
  };

  parseUrl = function(url) {
    var splitUrl;
    if (!url) throw "Error No Url Passed";
    splitUrl = url.split('/');
    return splitUrl[splitUrl.length - 1].split('-')[0];
  };

  getShotInfo = function(id, cb) {
    var options;
    options = {
      host: apiBasePath,
      port: 80,
      path: '/shots/' + id
    };
    return skinnyGetter(options, cb);
  };

  exports.getShotInfo = getShotInfo;

  exports.parseUrl = parseUrl;

}).call(this);
