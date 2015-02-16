var express = require('express');
var app = express();
var compression = require('compression');

app.all(/.*/, function(req, res, next) {
  if (req.headers.host.match(/^www/) !== null ) {
    res.redirect('http://' + req.headers.host.replace(/^www\./, '') + req.url);
  } else {
    next();
  }
});

app.use(compression());
app.set('port', (process.env.PORT || 5000));
app.use("/scripts", express.static(__dirname + "/dist/scripts"));
app.use("/fonts", express.static(__dirname + "/dist/fonts"));
app.use("/assets", express.static(__dirname + "/dist/assets"));
app.use("/styles", express.static(__dirname + "/dist/styles"));

// any other routes:
app.all("/*", function (req, res) {
  res.set('Content-Type', 'text/html')
    .sendFile(__dirname + '/dist/index.html');
});

app.listen(app.get('port'), function() {
  console.log("Node app is running at localhost:" + app.get('port'))
})
