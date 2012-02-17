window.Player = Backbone.RelationalModel.extend
  relations: [
    type:           Backbone.HasMany
    key:            "territories"
    relatedModel:   "Territory"
    collectionType: "Territories"
    reverseRelation:
      key: "owner"
  ]

  initialize: ->
    @bind("add:territories",                 @countDeployedUnits)
    @bind("remove:territories",              @countDeployedUnits)
    @bind("territories:units_count_changed", @countDeployedUnits)


  # TODO: Prevent this method to be called when data are seeded.
  countDeployedUnits: ->
    iterator = (total, territory)-> total + territory.get("unitsCount")
    newCount = @get("territories").reduce(iterator, 0)
    @set(deployedUnitsCount: newCount)
