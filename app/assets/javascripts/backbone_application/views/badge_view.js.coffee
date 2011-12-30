window.BadgeView = Backbone.View.extend
  model:     Territory
  tagName:   "li"

  events:
    "click" : "handleClick"


  initialize: ->
    @model.bind("change:unitsCount", @changeUnitsCount, @)
    @model.bind("change:owner",      @changeOwner,      @)
    @model.bind("fade",              @fade,             @)
    @model.bind("unfade",            @unfade,           @)


  render: ->
    $(@el)
      .attr
        id:    "badge_" + @model.get("id")
        color: @model.get("owner").get("color")
      .append($("<span />", text: @model.get("unitsCount")))

    @


  changeUnitsCount: ->
    unitsCount = @model.get("unitsCount")
    $span      = @$("span").toggleClass("animated")
    change     = -> $span.text(unitsCount)

    setTimeout(change, 400)


  changeOwner: ->
    $(@el).attr(color: @model.get("owner").get("color"))


  handleClick: ->
    clickedTerritory  = @model
    selectedTerritory = window.game.get("selectedTerritory")


    if selectedTerritory
      if clickedTerritory is selectedTerritory
        window.game.unselectTerritory(clickedTerritory)

      else
        if selectedTerritory.get("neighbours").include(clickedTerritory)
          window.game.interactWithTerritory(clickedTerritory)
        else
          window.game.selectTerritory(clickedTerritory)

    else
      if clickedTerritory.get("owner") is window.me and window.me.get("active")
        window.game.selectTerritory(clickedTerritory)


  fade: ->
    $(@el).addClass("faded")


  unfade: ->
    $(@el).removeClass("faded")
