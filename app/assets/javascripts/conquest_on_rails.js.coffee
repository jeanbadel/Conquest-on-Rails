window.ConquestOnRails =
  Views:       {}
  Models:      {}
  Routers:     {}
  Collections: {}

  init: ->
    window.juggernaut ||= new Juggernaut
    new window.GameRouter
    Backbone.history.start(pushState: true)


jQuery ->
  ConquestOnRails.init()
