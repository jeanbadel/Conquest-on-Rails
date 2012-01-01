window.AttackBoxView = Backbone.View.extend
  model: Attack
  id:    "attack_box"

  events:
    "click .minus" : "decrementAttackersCount"
    "click .plus"  : "incrementAttackersCount"


  initialize: ->
    @model.bind("change:attackersCount", @attackersCountChanged, @)
    @model.bind("destroy",               @destroy,               @)
    @model.bind("change:done",           @doneChanged,           @)


  render: ->
    source   = $("#attack-box-view-template").html()
    template = Handlebars.compile(source)
    viewData = attackersCount: @model.get("attackersCount")
    content  = template(viewData)

    $(@el)
      .addClass("hidden")
      .html(content)

    @


  decrementAttackersCount: ->
    @model.set(attackersCount: @model.get("attackersCount") - 1)


  incrementAttackersCount: ->
    @model.set(attackersCount: @model.get("attackersCount") + 1)


  attackersCountChanged: ->
    @$(".counter").text(@model.get("attackersCount"))


  destroy: ->
    me = @
    $(@el).addClass("hidden")
    deleteElement = -> me.remove()
    setTimeout(deleteElement, 800)


  show: ->
    $badge = $("#badge_" + @model.get("target").get("id"))

    $(@el)
      .position(my: "left", at: "right", of: $badge)
      .removeClass("hidden")


  doneChanged: ->
    if @model.get("done")
      window.game.unselectTerritory()
      @destroy()
