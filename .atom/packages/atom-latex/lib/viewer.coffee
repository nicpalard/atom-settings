{ Disposable } = require 'atom'
getCurrentWindow = require('electron').remote.getCurrentWindow
BrowserWindow = require('electron').remote.BrowserWindow
fs = require 'fs'
path = require 'path'

module.exports =
class Viewer extends Disposable
  constructor: (latex) ->
    @latex = latex
    @client = {}

  dispose: ->
    if @window? and !@window.isDestroyed()
      @window.destroy()

  wsHandler: (ws, msg) ->
    data = JSON.parse msg
    switch data.type
      when 'open'
        @client.ws?.close()
        @client.ws = ws
      when 'loaded'
        if @client.position and @client.ws?
          @client.ws.send JSON.stringify @client.position
      when 'position'
        @client.position = data
      when 'click'
        @latex.locator.locate(data)
      when 'close'
        @client.ws = undefined

  refresh: ->
    @client.ws?.send JSON.stringify type: "refresh"
    @latex.viewer.focusViewer()
    if !atom.config.get('atom-latex.focus_viewer')
      @latex.viewer.focusMain()

  focusViewer: ->
    @window.focus() if @window? and !@window.isDestroyed()

  focusMain: ->
    @self.focus() if @self?

  synctex: (record) ->
    @client.ws?.send JSON.stringify
      type: "synctex"
      data: record
    if atom.config.get('atom-latex.focus_viewer')
      @focusViewer()

  openViewer: ->
    if @client.ws?
      @refresh()
    else if atom.config.get('atom-latex.preview_after_build') is\
        'View in PDF viewer window'
      @openViewerNewWindow()
    else if atom.config.get('atom-latex.preview_after_build') is\
        'View in PDF viewer tab'
      @openViewerNewTab()

  openViewerNewWindow: ->
    if !@latex.manager.findMain()
      return

    pdfPath = """#{@latex.mainFile.substr(
      0, @latex.mainFile.lastIndexOf('.'))}.pdf"""
    if !fs.existsSync pdfPath
      return

    if !@getUrl()
      return

    if @tabView? and atom.workspace.paneForItem(@tabView)?
      atom.workspace.paneForItem(@tabView).destroyItem(@tabView)
      @tabView = undefined
    if !@window? or @window.isDestroyed()
      @self = getCurrentWindow()
      @window = new BrowserWindow()
    else
      @window.show()
      @window.focus()

    @window.loadURL(@url)
    @window.setMenuBarVisibility(false)
    @window.setTitle("""Atom-LaTeX PDF Viewer - [#{@latex.mainFile}]""")

  openViewerNewTab: ->
    if !@latex.manager.findMain()
      return

    pdfPath = """#{@latex.mainFile.substr(
      0, @latex.mainFile.lastIndexOf('.'))}.pdf"""
    if !fs.existsSync pdfPath
      return

    if !@getUrl()
      return

    if @tabView? and atom.workspace.paneForItem(@tabView)?
      atom.workspace.paneForItem(@tabView).activateItem(@tabView)
    else
      @tabView = new PDFView(@url,path.basename(pdfPath))
      atom.workspace.getActivePane().splitRight().addItem(@tabView)

  getUrl: ->
    try
      { address, port } = @latex.server.http.address()
      @url = """http://#{address}:#{port}/viewer.html?file=preview.pdf"""
    catch err
      @latex.server.openTab = true
      return false
    return true

class PDFView
  constructor: (url,title) ->
    @element = document.createElement 'iframe'
    @element.setAttribute 'src', url
    @element.setAttribute 'width', '100%'
    @element.setAttribute 'height', '100%'
    @element.setAttribute 'frameborder', 0,
    @title = title

  getTitle: ->
    return """Atom-LaTeX - #{@title}"""

  serialize: ->
    return @element.getAttribute 'src'

  destroy: ->
    @element.remove()

  getElement: ->
    return @element
