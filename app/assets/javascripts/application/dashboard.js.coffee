window.juggernaut ||= new Juggernaut

$ ->
  $("#dashboard").delegate ".participation a.disabled", "click", (event)->
    event.preventDefault()


  $("#dashboard .participation").each (index, participation)->
    $participation = $(participation)
    gameId         = $participation.data("game")

    # Avoid the new participation.
    if gameId
      channel = "games/#{gameId}"

      juggernaut.subscribe channel, (data)->
        handlers[data.eventType](data)


handlers =
  # Colorize the placeholder.
  PLAYER_JOIN: (data)->
    $participation = $(".participation[data-game=#{data.gameId}]")
    classToRemove  = "#{data.color}_placeholder"

    $participation
      .find(".#{classToRemove}")
      .removeClass(classToRemove)
      .attr("color", data.color)


  # Enable the button.
  START: (data)->
    $participation = $(".participation[data-game=#{data.gameId}]")
    $button        = $participation.find("a")

    $button.text($button.data("enable-with"))
    $button.removeClass("disabled")
    $button.addClass("success")
