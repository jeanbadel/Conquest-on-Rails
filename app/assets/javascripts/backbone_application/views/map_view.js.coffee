class window.MapView extends Backbone.View
  id:    "map"
  model: Game


  render: ->
    source   = $("#map-view-template").html()
    template = Handlebars.compile(source)
    content  = template()

    $(@el).html(content)
    $map  = @$("map")
    $list = @$("ul")

    @model.get("territories").each (territory)->
      territoryView = new TerritoryView(model: territory)
      badgeView     = new BadgeView(model: territory)

      $map.append(territoryView.render().el)
      $list.append(badgeView.render().el)

    @