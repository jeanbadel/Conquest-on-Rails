class window.Game extends Backbone.Model
  initialize: ->
    @bind("change:currentPlayer", @handleCurrentPlayerChange)


  handleCurrentPlayerChange: ->
    @get("players").each (player)-> player.set(active: false)
    @get("currentPlayer").set(active: true)
