window.Territory = Backbone.RelationalModel.extend
  relations: [
    type:           Backbone.HasMany
    key:            "neighbours"
    relatedModel:   "Territory",
    collectionType: "Territories"
  ]


  initialize: ->
    @bind("change:unitsCount", @unitsCountChanged, @)


  unitsCountChanged: ->
    @get("owner").trigger("territories:units_count_changed")


  deploy: (count)->
    ownerUnitsCount = @get("owner").get("unitsCount")

    if 0 < ownerUnitsCount
      @set(unitsCount: @get("unitsCount") + count)
      @get("owner").set(unitsCount: ownerUnitsCount - count)
