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
    deployment = new Deployment(territory: @, unitsCount: count)
    deployment.execute()


  canAttack: ->
    return false if @get("unitsCount") is 1
    return false if @enemyNeighbours().length is 0
    true


  enemyNeighbours: ->
    owner = @get("owner")

    @get("neighbours").reject (neighbour)->
      owner is neighbour.get("owner")
