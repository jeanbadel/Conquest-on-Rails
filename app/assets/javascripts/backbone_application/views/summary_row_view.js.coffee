class window.SummaryRowView extends Backbone.View
  model:   Player
  tagName: "tr"

  initialize: ->
    @model.bind("change",         @render, @)
    @model.bind("change:current", @render, @)


  render: ->
    viewData =
      name:             @model.get("name")
      color:            @model.get("color")
      unitsCount:       @model.get("deployedUnitsCount")
      territoriesCount: @model.get("territories").length

    source   = $("#summary-row-view-template").html()
    template = Handlebars.compile(source)
    content  = template(viewData)

    $(@el)
      .html(content)
      .removeClass("current")
      .addClass(@model.get("active") && "current")

    @
