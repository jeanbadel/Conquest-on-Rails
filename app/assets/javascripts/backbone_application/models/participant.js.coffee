class window.Participant extends Backbone.RelationalModel
  relations: [
    type:           Backbone.HasMany
    key:            "territories"
    relatedModel:   "Territory"
    collectionType: "Territories"
    reverseRelation:
      key: "owner"
  ]
