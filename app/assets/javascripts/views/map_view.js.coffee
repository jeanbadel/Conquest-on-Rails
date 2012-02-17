window.MapView = Backbone.View.extend
  id:       "map"
  model:    Game
  template: JST["map"]

  initialize: ->
    @model.bind("change:ongoingAttack",         @ongoingAttackChanged, @)
    @model.bind("change:targetableTerritories", @targetableTerritoriesChanged, @)


  render: ->
    content = @template()

    $(@el).html(content)
    $map  = @$("map")
    $list = @$("ul")

    @model.get("territories").each (territory)->
      territoryView = new TerritoryView(model: territory)
      badgeView     = new BadgeView(model: territory)

      $map.append(territoryView.render().el)
      $list.append(badgeView.render().el)

    @


  ongoingAttackChanged: ->
    attack = @model.get("ongoingAttack")

    if attack
      attackBoxView = new AttackBoxView(model: attack)
      attackBoxEl   = attackBoxView.render().el

      $(@el).append(attackBoxEl)
      attackBoxView.show()


  targetableTerritoriesChanged: ->
    selectedTerritory     = @model.get("selectedTerritory")
    targetableTerritories = @model.get("targetableTerritories")

    if targetableTerritories.isEmpty()
      @model.get("territories").invoke("trigger", "unfade")

    else
      @model.get("territories").each (territory)->
        if territory is selectedTerritory or targetableTerritories.include(territory)
          territory.trigger("unfade")
        else
          territory.trigger("fade")
