jQuery ->
  window.game = new Game
    id:            window.seeds.gameId
    players:       window.seeds.players
    territories:   window.seeds.territories
    currentPlayer: window.seeds.currentPlayer

  mapView     = new MapView(model: window.game)
  summaryView = new SummaryView(model: window.game)

  $("#application")
    .append(mapView.render().el)
    .append(summaryView.render().el)
