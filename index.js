var express = require('express');

// Constants
var DEFAULT_PORT = 6500;
var PORT = process.env.PORT || DEFAULT_PORT;

// App
var app = express()
  , gracefullyExiting = false

// Return 502 while the server is shutting down
app.use(function (req, res, next) {
  if (!gracefullyExiting) {
    return next()
  }
  res.set('Connection', 'close')
  res.send(502, 'Server is in the process of restarting.')
})

app.get('/', function (req, res) {
  res.send('Hello Adam\n');
});

var server = app.listen(PORT)
console.log('Running on http://localhost:' + PORT);

// Graceful shutdown taken from: http://blog.argteam.com/
process.on('SIGTERM', function () {
  gracefullyExiting = true
  console.log('Received kill signal (SIGTERM), shutting down')

  setTimeout(function () {
    console.log('Could not close connections in time, forcefully shutting down')
    process.exit(1)
  }, 30000)

  server.close(function () {
    console.log('Closed out remaining connections.')
    process.exit()
  })
})