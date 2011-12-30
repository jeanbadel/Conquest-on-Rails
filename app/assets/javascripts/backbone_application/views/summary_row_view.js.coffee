class window.SummaryRowView extends Backbone.View
  model:   Player
  tagName: "tr"

  initialize: ->
    @model.bind("change:active",             @activityChanged,         @)
    @model.bind("change:deployedUnitsCount", @unitsCountChanged,       @)
    @model.bind("add:territories",           @territoriesCountChanged, @)
    @model.bind("remove:territories",        @territoriesCountChanged, @)


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
      .addClass(@model.get("active") && "current")

    @


  activityChanged: ->
    $(@el)
      .removeClass("current")
      .addClass(@model.get("active") && "current")


  unitsCountChanged: ->
    unitsCount = @model.get("deployedUnitsCount")
    $td        = @$(".units_count").toggleClass("animated")
    $span      = $td.find("span")

    change = -> $span.text(unitsCount)
    setTimeout(change, 200)


  territoriesCountChanged: ->
    territoriesCount = @model.get("territories").length
    $td              = @$(".territories_count").toggleClass("animated")
    $span            = $td.find("span")

    change = -> $span.text(territoriesCount)
    setTimeout(change, 200)
