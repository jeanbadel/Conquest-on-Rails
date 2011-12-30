window.Game = Backbone.Model.extend
  initialize: ->
    @bind("change:currentPlayer",     @currentPlayerChanged,     @)
    @bind("change:selectedTerritory", @selectedTerritoryChanged, @)


  currentPlayerChanged: ->
    @get("players").each (player)-> player.set(active: false)
    @get("currentPlayer").set(active: true)



  selectTerritory: (territory)->
    @set(selectedTerritory: territory)


  unselectTerritory: (territory)->
    @set(selectedTerritory: null)


  interactWithTerritory: (territory)->
    alert("Interact with territory #{territory.get("id")}")


  selectedTerritoryChanged: ->
    territories           = @get("territories")
    selectedTerritory     = @get("selectedTerritory")

    if selectedTerritory
      neighbours = selectedTerritory.get("neighbours")

      # Fade all territories but the selected one and its neighbours.
      territories.each (territory)->
        if territory is selectedTerritory or neighbours.include(territory)
          territory.trigger("unfade")
        else
          territory.trigger("fade")

    else
      # No selected territory anymore.
      territories.invoke("trigger", "unfade")
