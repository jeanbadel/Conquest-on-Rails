window.Game = Backbone.Model.extend
  initialize: ->
    @bind("change:currentPlayer",     @currentPlayerChanged,     @)
    @bind("change:selectedTerritory", @abortOngoingAttack,       @)
    @bind("change:selectedTerritory", @selectedTerritoryChanged, @)
    @bind("change:targetedTerritory", @targetedTerritoryChanged, @)

    currentPlayer = @get("players").find (player)-> player.get("active")
    @set(currentPlayer: currentPlayer)

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
    @set(selectedTerritory: null, targetedTerritory: null)


  targetTerritory: (territory)->
    @abortOngoingAttack()
    attack = new Attack(attacker: @get("selectedTerritory"), target: territory)
    @set(targetedTerritory: territory, ongoingAttack: attack)


  untargetTerritory: ->
    @set(targetedTerritory: null, ongoingAttack: null)


  attackTerritory: (territory)->
    @get("ongoingAttack").execute()


  selectedTerritoryChanged: ->
    myTerritories     = window.me.get("territories")
    selectedTerritory = @get("selectedTerritory")

    if selectedTerritory
      @set(targetableTerritories: new Territories(@targetableTerritories()))

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


  deploymentOccured: (data)->
    territory  = @get("territories").get(data.targetTerritoryId)
    owner      = territory.get("owner")
    unitsCount = data.unitsCount

    @set(phase: data.phase)

    if owner isnt window.me
      newTerritoryUnitsCount = territory.get("unitsCount") + unitsCount
      territory.set(unitsCount: newTerritoryUnitsCount)

      newOwnerUnitsCount = owner.get("unitsCount") - unitsCount
      owner.set(unitsCount: newOwnerUnitsCount)


  targetableTerritories: ->
    selectedTerritory = @get("selectedTerritory")
    myTerritories     = selectedTerritory.get("owner").get("territories")
    neighbours        = selectedTerritory.get("neighbours")

    if @get("phase") is Game.MOVE
      _.intersection(neighbours.models, myTerritories.models)
    else
      neighbours.without(myTerritories.models)


Game.DEPLOYMENT = "DEPLOYMENT"
Game.ATTACK     = "ATTACK"
Game.MOVE       = "MOVE"
