class window.Territory extends Backbone.RelationalModel
  relations: [
    type:           Backbone.HasMany
    key:            "neighbours"
    relatedModel:   "Territory",
    collectionType: "Territories"
  ]


  initialize: ->
    @bind("change:unitsCount", @handleUnitsCountChange, @)


  handleUnitsCountChange: ->
    @get("owner").trigger("territories:units_count_changed")
