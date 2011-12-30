class window.Game extends Backbone.Model
  initialize: ->
    @bind("change:currentPlayer", @handleCurrentPlayerChange)

  handleCurrentPlayerChange: ->
    @get("players")
    console.log "handleCurrentPlayerChange"