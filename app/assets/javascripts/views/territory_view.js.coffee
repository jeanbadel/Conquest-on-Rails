window.TerritoryView = Backbone.View.extend
  model:   Territory
  tagName: "area"

  events:
    "click": "handleClick"


  handleClick: ->
    false


  render: ->
    $(@el).attr(shape: "poly", coords: @model.get("path"), href: '#')
    @
