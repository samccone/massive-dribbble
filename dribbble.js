(function() {
  var apiBasePath, getShotInfo, http, parseUrl, request;

  http = require('http');

  request = require('request');

  apiBasePath = 'api.dribbble.com';

  parseUrl = function(url) {
    var splitUrl;
    if (!url) throw "Error: No Url Passed";
    splitUrl = url.split('/');
    return splitUrl[splitUrl.length - 1].split('-')[0];
  };

  getShotInfo = function(id, callback) {
    return request("http://" + apiBasePath + "/shots/" + id, function(error, res, body) {
      if (error) {
        throw "FLAGRANT ERROR! " + error;
      } else {
        return callback(JSON.parse(body));
      }
    });
  };

  exports.getShotInfo = getShotInfo;

  exports.parseUrl = parseUrl;

}).call(this);
