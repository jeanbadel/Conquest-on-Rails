window.BadgeView = Backbone.View.extend
  model:     Territory
  tagName:   "li"

  events:
    "click" : "handleClick"


  initialize: ->
    @model.bind("change:unitsCount", @unitsCountChanged, @)
    @model.bind("change:owner",      @ownerChanged,      @)
    @model.bind("fade",              @fade,             @)
    @model.bind("unfade",            @unfade,           @)


  render: ->
    $(@el)
      .attr
        id:    "badge_" + @model.get("id")
        color: @model.get("owner").get("color")
      .append($("<span />", text: @model.get("unitsCount")))

    @


  unitsCountChanged: ->
    unitsCount = @model.get("unitsCount")
    $span      = @$("span").toggleClass("animated")
    change     = -> $span.text(unitsCount)

    setTimeout(change, 400)


  ownerChanged: ->
    $(@el).attr(color: @model.get("owner").get("color"))


  handleClick: ->
    clickedTerritory      = @model
    selectedTerritory     = window.game.get("selectedTerritory")
    targetableTerritories = window.game.get("targetableTerritories")
    targetedTerritory     = window.game.get("targetedTerritory")

    if not selectedTerritory
      if clickedTerritory.get("owner") is window.me and window.me.get("active")
        window.game.selectTerritory(clickedTerritory)

    else
      if clickedTerritory is selectedTerritory
        window.game.unselectTerritory()

      else if clickedTerritory is targetedTerritory
        window.game.attackTerritory(clickedTerritory)

      else if targetableTerritories.include(clickedTerritory)
        window.game.targetTerritory(clickedTerritory)

      else
        if clickedTerritory.get("owner") is window.me and window.me.get("active")
          window.game.selectTerritory(clickedTerritory)


  fade: ->
    $(@el).addClass("faded")


  unfade: ->
    $(@el).removeClass("faded half-faded")
