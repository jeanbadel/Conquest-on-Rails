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
