window.Deployment = Backbone.Model.extend
  validate: (attributes)->
    if @get("territory").get("owner").get("unitsCount") is 0
      return "NoMoreUnitToDeploy"


  execute: ->
    me         = @
    territory  = @get("territory")
    owner      = territory.get("owner")
    unitsCount = @get("unitsCount")

    newTerritoryUnitsCount = territory.get("unitsCount") + unitsCount
    territory.set(unitsCount: newTerritoryUnitsCount)

    newOwnerUnitsCount = owner.get("unitsCount") - unitsCount
    owner.set(unitsCount: newOwnerUnitsCount)

    unless @get("done")
      $.ajax "/games/#{window.game.id}/deployments",
        type:     "POST"
        dataType: "json"
        success: ->
          me.set(done: true)
        data:
          territory_id: territory.get("id")
          units_count:  unitsCount
