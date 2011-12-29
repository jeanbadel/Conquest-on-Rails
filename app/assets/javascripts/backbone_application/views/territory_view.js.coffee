class window.TerritoryView extends Backbone.View
  model:   Territory
  tagName: "area"

  events:
    "click": "handleClick"


  handleClick: ->
    false


  render: ->
    $(@el).attr(shape: "poly", coords: @model.get("path"), href: '#')
    @
