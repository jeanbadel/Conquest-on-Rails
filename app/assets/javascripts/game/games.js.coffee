window.juggernaut ||= new Juggernaut

$ ->
  $("#map").each (index, map)->
    $map = $(map)


showFloatingText = ($element, label, additionnalClass)->
  $("<div />", class: "floating_text", text: label)
    .addClass(additionnalClass)
    .appendTo($("body"))
    .position(my: "bottom", at: "top", of: $element)
    .animate(top: "-=30px", { duration: 2500, queue: false })
    .delay(1500)
    .fadeOut(1000, -> $(this).remove())
