window.BadgeView = Backbone.View.extend
  model:   Territory
  tagName: "li"

  events:
    "click" : "handleClick"


  initialize: ->
    @model.bind("change:unitsCount", @unitsCountChanged, @)
    @model.bind("change:owner",      @ownerChanged,      @)
    @model.bind("fade",              @fade,              @)
    @model.bind("unfade",            @unfade,            @)


  render: ->
    domId   = "badge_" + @model.get("id")
    color   = @model.get("owner").get("color")
    $span   = $("<span />", text: @model.get("unitsCount"))
    $badge  = $("<div />", color: color, class: "badge").append($span)
    $circle = $("<div />", class: "selection_circle")

    $(@el)
      .attr(id: domId)
      .append($badge)
      .append($circle)

    @


  unitsCountChanged: ->
    unitsCount = @model.get("unitsCount")
    $span      = @$("span").toggleClass("animated")
    change     = -> $span.text(unitsCount)

    setTimeout(change, 400)


  ownerChanged: ->
    @$(".badge").attr(color: @model.get("owner").get("color"))


  handleClick: ->
    phase                 = window.game.get("phase")
    clickedTerritory      = @model
    selectedTerritory     = window.game.get("selectedTerritory")
    targetableTerritories = window.game.get("targetableTerritories")
    targetedTerritory     = window.game.get("targetedTerritory")

    if phase is Game.DEPLOYMENT
      if clickedTerritory.get("owner") is window.me and window.me.get("active")
        clickedTerritory.deploy(1)

    else
      if not selectedTerritory
        if clickedTerritory.get("owner") is window.me and window.me.get("active")
          window.game.selectTerritory(clickedTerritory)

      else
        if clickedTerritory is selectedTerritory
          window.game.unselectTerritory()

        else if clickedTerritory is targetedTerritory
          if phase is Game.ATTACK
            window.game.attackTerritory(clickedTerritory)
          else if phase is Game.MOVE
            window.game.moveToTerritory(clickedTerritory)

        else if targetableTerritories.include(clickedTerritory)
          window.game.targetTerritory(clickedTerritory)

        else
          if clickedTerritory.get("owner") is window.me and window.me.get("active")
            window.game.selectTerritory(clickedTerritory)


  fade: ->
    @$(".badge").addClass("faded")


  unfade: ->
    @$(".badge").removeClass("faded")
