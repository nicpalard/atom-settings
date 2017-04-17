{ Disposable } = require 'atom'
http = require 'http'
ws = require 'ws'
fs = require 'fs'
path = require 'path'

module.exports =
class Server extends Disposable
  constructor: (latex) ->
    @latex = latex

    @http = http.createServer (req, res) => @httpHandler(req, res)
    @httpRoot = """#{path.dirname(__filename)}/../viewer"""
    @listen = new Promise (c, e) =>
      @http.listen 0, 'localhost', undefined, (err) =>
        if err
          e(err)
        else if @latex.server.openTab
          @latex.viewer.openViewerNewWindow()

    @ws = ws.createServer server: @http
    @ws.on "connection", (ws) =>
      ws.on "message", (msg) => @latex.viewer.wsHandler(ws, msg)
      ws.on "close", () => @latex.viewer.wsHandler(ws, '{"type":"close"}')

  httpHandler: (request, response) ->
    if request.url.indexOf('viewer.html') > -1
      response.writeHead 200, 'Content-Type': 'text/html'
      response.end fs.readFileSync("""#{@httpRoot}/viewer.html"""), 'utf-8'
      return

    if request.url.indexOf('preview.pdf') > -1
      if !@latex.manager.findMain()
        response.writeHead 404
        response.end()
        return

      pdfPath = """#{@latex.mainFile.substr(
        0, @latex.mainFile.lastIndexOf('.'))}.pdf"""
      pdfSize = fs.statSync(pdfPath).size
      response.writeHead 200,
        'Content-Type': 'application/pdf',
        'Content-Length': pdfSize
      fs.createReadStream(pdfPath).pipe(response)
      return

    file = path.join @httpRoot, request.url.split('?')[0]
    switch path.extname(file)
      when '.js'
        contentType = 'text/javascript'
      when '.css'
        contentType = 'text/css'
      when '.json'
        contentType = 'application/json'
      when '.png'
        contentType = 'image/png'
      when '.jpg'
        contentType = 'image/jpg'
      else
        contentType = 'text/html'

    fs.readFile file, (err, content) ->
      if err
        if err.code == 'ENOENT'
          response.writeHead 404
        else
          response.writeHead 500
        response.end()
      else
        response.writeHead 200, 'Content-Type': contentType
        response.end content, 'utf-8'
