window.Attack = Backbone.Model.extend
  initialize: ->
    @set(attackersCount: @maximumAttackersCount())
    @bind("change:done", @doneChanged, @)


  validate: (attributes)->
    if attributes.attackersCount < 1
      return "TooFewAttackers"

    if @maximumAttackersCount() < attributes.attackersCount
      return "TooManyAttackers"

    undefined


  maximumAttackersCount: ->
    @get("attacker").get("unitsCount") - 1


  execute: ->
    me = @

    unless @get("done")
      $.ajax "/games/#{window.game.id}/attacks",
        type:     "POST"
        dataType: "json"
        success: ->
          me.set(done: true)
        data:
          attacker_id:     @get("attacker").get("id")
          target_id:       @get("target").get("id")
          attackers_count: @get("attackersCount")


  doneChanged: ->
    window.game.unselectTerritory()
    window.game.set(targetedTerritory: null, ongoingAttack: null)
