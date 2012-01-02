class AttacksController < ApplicationController
  def create
    game               = current_participation.game
    attackers_count    = params[:attackers_count].to_i
    attacker_ownership = current_participation.ownerships.find_by_territory_id(params[:attacker_id])
    target_ownership   = game.ownerships.find_by_territory_id(params[:target_id])
    attack             = attacker_ownership.attack!(target_ownership, attackers_count)

    Juggernaut.publish(
      "games/#{game.id}",
      eventType:           "attackOccured",
      attackersCount:      attackers_count,
      attackerTerritoryId: attacker_ownership.territory_id,
      targetTerritoryId:   target_ownership.territory_id,
      attackerLosses:      attack.attacker_losses,
      targetLosses:        attack.defender_losses,
      attackerWon:         attacker_ownership == attack.winner
    )

    render json: true
  end
end
