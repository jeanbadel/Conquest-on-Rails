jQuery ->
  window.game = new Game
    id:            window.seeds.gameId
    phase:         window.seeds.phase
    players:       window.seeds.players
    territories:   window.seeds.territories

  mapView                   = new MapView(model: window.game)
  summaryView               = new SummaryView(model: window.game)
  window.reinforcementsCounterView = new ReinforcementsCounterView(model: window.game)

  $("#application")
    .append(mapView.render().el)
    .append(reinforcementsCounterView.render().el)
    .append(summaryView.render().el)
