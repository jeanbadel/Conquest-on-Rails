window.SummaryRowView = Backbone.View.extend
  model:   Player
  tagName: "tr"

  initialize: ->
    @model.bind("change:active",             @activityChanged,           @)
    @model.bind("change:deployedUnitsCount", @deployedUnitsCountChanged, @)
    @model.bind("add:territories",           @territoriesCountChanged,   @)
    @model.bind("remove:territories",        @territoriesCountChanged,   @)
    @model.bind("change:unitsCount",         @unitsCountChanged,         @)


  render: ->
    viewData =
      name:               @model.get("name")
      color:              @model.get("color")
      unitsCount:         @model.get("unitsCount")
      deployedUnitsCount: @model.get("deployedUnitsCount")
      territoriesCount:   @model.get("territories").length

    source   = $("#summary-row-view-template").html()
    template = Handlebars.compile(source)
    content  = template(viewData)

    $(@el)
      .html(content)
      .addClass(@model.get("active") && "current")

    @$(".units_to_deploy").hide() if @model.get("unitsCount") == 0

    @


  activityChanged: ->
    $(@el)
      .removeClass("current")
      .addClass(@model.get("active") && "current")


  deployedUnitsCountChanged: ->
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


  unitsCountChanged: ->
    unitsCount = @model.get("unitsCount")

    if 0 < unitsCount
      @$(".units_count .units_to_deploy")
        .text("+#{unitsCount}")
        .show()

    else
      @$(".units_count .units_to_deploy").hide()
