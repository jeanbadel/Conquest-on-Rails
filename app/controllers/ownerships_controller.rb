class OwnershipsController < ApplicationController
  def attack
    attackers_count = params[:attackers_count].to_i
    @game           = current_participation.game
    @attacker       = current_participation.ownerships.find(params[:id])
    @target         = @game.ownerships.find_by_territory_id(params[:target_id])
    @target_color   = @target.participation.color
    @attack         = @attacker.attack!(@target, attackers_count)

    publish_attack_report_to_players

    render :nothing => true
  end


  def deploy
    render :nothing => true
  end


  private

  def publish_attack_report_to_players
    Juggernaut.publish("games/#{@game.id}", {
      eventType: "ATTACK_REPORT",
      attacker: {
        unitsLoss:           @attack.attacker_losses,
        territoryId:         @attacker.territory_id,
        color:               @attacker.participation.color,
        winner:              @attacker == @attack.winner,
        unitsCount:          @attack.attackers_count,
        remainingUnitsCount: @attack.remaining_attackers_count
      },
      target: {
        unitsLoss:   @attack.defender_losses,
        territoryId: @target.territory_id,
        color:       @target_color
      }
    })
  end
end
