window.juggernaut ||= new Juggernaut

$ ->
  $("#map").each (index, map)->
    $map    = $(map)
    gameId  = $map.data("game_id")
    channel = "games/#{gameId}"
    
    juggernaut.singleSubscribe channel, (data)->
      handlers[data.eventType](data)


showFloatingText = ($element, label, additionnalClass)->
  $("<div />", class: "floating_text", text: label)
    .addClass(additionnalClass)
    .appendTo($("body"))
    .position(my: "bottom", at: "top", of: $element)
    .animate(top: "-=30px", { duration: 2500, queue: false })
    .delay(1500)
    .fadeOut(1000, -> $(this).remove())


changeUnitsCount = ($badge, newUnitsCount)->
  $badge.data("units_count", newUnitsCount)
  $badge.find("span").fadeOut 300, ->
    $(this).text(newUnitsCount).fadeIn(300)


handlers =
  UNITS_LOSSES: (data)->
    for loss in data.losses when 0 < loss.unitsLoss
      $badge        = $("#badge_territory_#{loss.territoryId}")
      label         = "− #{loss.unitsLoss}"
      unitsCount    = $badge.data("units_count")
      newUnitsCount = unitsCount - loss.unitsLoss
      
      showFloatingText($badge, label, "malus")
      changeUnitsCount($badge, newUnitsCount)
