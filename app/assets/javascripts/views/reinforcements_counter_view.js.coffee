window.ReinforcementsCounterView = Backbone.View.extend
  model: Game

  initialize: ->
    currentPlayer = @model.get("currentPlayer")

    @model.bind("change:currentPlayer",     @render, @)
    currentPlayer.bind("change:unitsCount", @render, @)


  render: ->
    if(window.me == @model.get("currentPlayer"))
      unitsCount = @model.get("currentPlayer").get("unitsCount")
      $(@el).text("#{unitsCount} renforts").removeClass("hide")

    else
      $(@el).addClass("hide")

    @
