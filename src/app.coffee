http = require('follow-redirects').http
url = require 'url'

port = process.argv[2] or process.env.PORT or 3000

corsify = (res) ->
  res.setHeader 'Access-Control-Allow-Origin', '*'
  res.setHeader 'Access-Control-Allow-Methods', 'GET'
  res.setHeader 'Access-Control-Allow-Headers', 'Content-Type'

fetch = (url, endPipe) ->
  req = http.get url, (res) ->
    res.pipe endPipe
  req.on 'error', (e) ->
    console.error e
    endPipe.end()

server = http.createServer (req, res) ->
  location = url.parse(req.url, true).query.url
  if location
    console.log "Got a request for #{location}"
    corsify res
    fetch location, res
  else
    res.end()

server.listen port, ->
  console.log "Server listening on port #{port}"

