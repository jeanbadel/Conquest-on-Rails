window.GameRouter = Backbone.Router.extend
  routes:
    "games/:id" : "show"


  show: (gameId)->
    console.log "Game!", gameId
    window.game = new Game
      id:          window.seeds.gameId
      phase:       window.seeds.phase
      players:     window.seeds.players
      territories: window.seeds.territories

    mapView     = new MapView(model: window.game)
    summaryView = new SummaryView(model: window.game)

    $("#application")
      .append(mapView.render().el)
      .append(summaryView.render().el)

    game.trigger("change:phase")

