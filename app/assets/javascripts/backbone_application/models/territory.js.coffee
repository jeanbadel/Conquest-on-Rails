class window.Territory extends Backbone.RelationalModel
  relations: [
    type:           Backbone.HasMany
    key:            "neighbours"
    relatedModel:   "Territory",
    collectionType: "Territories"
  ]
