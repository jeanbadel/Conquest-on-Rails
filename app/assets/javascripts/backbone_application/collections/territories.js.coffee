window.Territories = Backbone.Collection.extend
  model: Territory

  buildNeighbours: ->
    me = @
    for territory in @models
      for neighbourId in territory.get("neighbourIds")
        neighbour = me.get(neighbourId)
        territory.get("neighbours").add(neighbour)

    @
