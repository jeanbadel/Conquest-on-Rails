class window.BadgeView extends Backbone.View
  model:     Territory
  tagName:   "li"

  initialize: ->
    @model.bind("change:unitsCount", @changeUnitsCount, @)
    @model.bind("change:owner",      @changeOwner, @)


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

    change = -> $span.text(unitsCount)
    setTimeout(change, 400)

    @


  changeOwner: ->
    $(@el).attr(color: @model.get("owner").get("color"))
    @
