class window.Territories extends Backbone.Collection
  model: Territory

  buildNeighbours: ->
    me = @
    for territory in @models
      for neighbourId in territory.get("neighbourIds")
        neighbour = me.get(neighbourId)
        territory.get("neighbours").add(neighbour)

    @
