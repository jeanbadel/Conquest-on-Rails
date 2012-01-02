window.Game = Backbone.Model.extend
  initialize: ->
    @bind("change:currentPlayer",     @currentPlayerChanged,     @)
    @bind("change:selectedTerritory", @abortOngoingAttack,       @)
    @bind("change:selectedTerritory", @selectedTerritoryChanged, @)
    @bind("change:targetedTerritory", @targetedTerritoryChanged, @)

    me      = @
    channel = "games/#{@get("id")}"

    window.juggernaut.subscribe channel, (data)->
      me[data.eventType](data)


  currentPlayerChanged: ->
    @get("players").each (player)-> player.set(active: false)
    @get("currentPlayer").set(active: true)


  selectTerritory: (territory)->
    @set(selectedTerritory: territory)


  unselectTerritory: ->
    @set(selectedTerritory: null)


  targetTerritory: (territory)->
    @abortOngoingAttack()
    attack = new Attack(attacker: @get("selectedTerritory"), target: territory)
    @set(targetedTerritory: territory, ongoingAttack: attack)


  untargetTerritory: ->
    @set(targetedTerritory: null)


  attackTerritory: (territory)->
    @get("ongoingAttack").execute()


  selectedTerritoryChanged: ->
    myTerritories     = window.me.get("territories")
    selectedTerritory = @get("selectedTerritory")

    if selectedTerritory
      neighbours            = selectedTerritory.get("neighbours")
      targetableTerritories = neighbours.without(myTerritories.models)

      @set(targetableTerritories: new Territories(targetableTerritories))

    else
      @set(targetableTerritories: new Territories([]))


  targetedTerritoryChanged: ->
    targetedTerritory = @get("targetedTerritory")

    @get("targetableTerritories").each (territory)->
      if territory is targetedTerritory
        territory.trigger("unfade")
      else
        territory.trigger("fade")


  abortOngoingAttack: ->
    @get("ongoingAttack") && @get("ongoingAttack").destroy()
    @set(ongoingAttack: null)


  attackOccured: (data)->
    attacker = @get("territories").get(data.attackerTerritoryId)
    target   = @get("territories").get(data.targetTerritoryId)

    if data.attackerWon
      newOwner                    = attacker.get("owner")
      remainingAttackerUnitsCount = attacker.get("unitsCount") - data.attackersCount
      remainingTargetUnitsCount   = data.attackersCount - data.attackerLosses

      attacker.set(unitsCount: remainingAttackerUnitsCount)
      target.set(owner: newOwner, unitsCount: remainingTargetUnitsCount)

    else
      attacker.set(unitsCount: attacker.get("unitsCount") - data.attackerLosses)
      target.set(unitsCount: target.get("unitsCount") - data.targetLosses)
