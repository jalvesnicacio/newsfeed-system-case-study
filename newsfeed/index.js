var express = require('express')
var app = express()
var ip = require('ip')
var os = require('os')

app.get('/', function (req, res) {
    res.send('Newsfeed Service says "Hello!"')
})

app.get('/server/url', function (req, res) {
    res.send(req.url)
})

app.get('/server/ipaddress', function (req, res) {
    res.send(ip.address())
})

app.get('/server/hostname', function (req, res) {
    res.send(os.hostname())
})

app.listen(8080, function () {
    console.log('Simple Node.js REST API listening on port 8080!')
})
