jQuery ->
  window.game = new Game
    players:     window.seeds.players
    territories: window.seeds.territories

  mapView     = new MapView(model: window.game)
  summaryView = new SummaryView(model: window.game)

  $("#application")
    .append(mapView.render().el)
    .append(summaryView.render().el)
