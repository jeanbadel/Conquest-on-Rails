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


showFloatingLoss = ($badge, unitsLoss)->
  return if unitsLoss == 0
  showFloatingText($badge, "− #{unitsLoss}", "malus")


removeUnitsFromBadge = ($badge, unitsLoss)->
  return if unitsLoss == 0
  unitsCount    = $badge.data("units_count")
  newUnitsCount = unitsCount - unitsLoss

  changeUnitsCountOnBadge($badge, newUnitsCount)


changeBadgeOwnership = ($badge, unitsCount, newColor)->
  oldColor = $badge.data("color")
  mine     = newColor == $("#map").data("me")
  $span    = $badge.find("span")

  $badge.data("units_count", unitsCount)
  $badge.data("color", newColor)
  $span.fadeOut 300, ->
    $badge
      .removeClass(oldColor)
      .removeClass("mine")
      .addClass(mine && "mine")
      .addClass(newColor)

    $span.text(unitsCount).fadeIn(300)


changeUnitsCountOnBadge = ($badge, unitsCount)->
  $span = $badge.find("span")

  $badge.data("units_count", unitsCount)
  $span.fadeOut 300, ->
    $span.text(unitsCount).fadeIn(300)


handlers =
  ATTACK_REPORT: (data)->
    console.log(data)

    attacker = data.attacker
    target   = data.target

    $attackerBadge = $("#badge_territory_#{attacker.territoryId}")
    $targetBadge   = $("#badge_territory_#{target.territoryId}")

    showFloatingLoss($attackerBadge, attacker.unitsLoss)
    showFloatingLoss($targetBadge, target.unitsLoss)

    if data.attacker.winner
      removeUnitsFromBadge($attackerBadge, attacker.unitsCount)
      changeBadgeOwnership($targetBadge, attacker.remainingUnitsCount, attacker.color)

    else
      removeUnitsFromBadge($attackerBadge, attacker.unitsLoss)
      removeUnitsFromBadge($targetBadge, target.unitsLoss)
