window.SummaryView = Backbone.View.extend
  model:     Game
  tagName:   "table"
  id:        "players"
  className: "zebra-striped"

  render: ->
    source   = $("#summary-view-template").html()
    template = Handlebars.compile(source)
    content  = template()

    $(@el).html(content)
    $tbody = @$("tbody")

    @model.get("players").each (player)->
      summaryRowView = new SummaryRowView(model: player)
      $tbody.append(summaryRowView.render().el)

    @
