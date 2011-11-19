window.juggernaut ||= new Juggernaut

$ ->
  $("#map").each (index, map)->
    $map = $(map)


showFloatingText = (territoryId, value)->
  $badge           = $("#badge_territory_#{territoryId}")  
  floatingTextId   = "floating_text_territory_#{territoryId}"
  additionnalClass = if 0 < value then "bonus" else "malus"
  
  $("<div />", id: floatingTextId, class: "floating_text", text: value)
    .addClass(additionnalClass)
    .appendTo($("body"))
    .position(my: "bottom", at: "top", of: $badge)
    .animate(top: "-=30px", { duration: 2500, queue: false })
    .delay(1500)
    .fadeOut(1000, -> $(this).remove())
