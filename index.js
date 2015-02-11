var express = require('express');
var app = express();

app.set('port', (process.env.PORT || 5000));
app.use("/scripts", express.static(__dirname + "/dist/scripts"));
app.use("/fonts", express.static(__dirname + "/dist/fonts"));
app.use("/assets", express.static(__dirname + "/dist/assets"));
app.use("/styles", express.static(__dirname + "/dist/styles"));

// any other routes:
app.all("/*", function (req, res) {
  res.set('Content-Type', 'text/html')
    .sendfile(__dirname + '/dist/index.html');
});

app.listen(app.get('port'), function() {
  console.log("Node app is running at localhost:" + app.get('port'))
})
