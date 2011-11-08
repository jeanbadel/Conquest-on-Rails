class OwnershipsController < ApplicationController
  def attack
    attackers_count = params[:attackers_count].to_i
    
    @game           = current_participation.game
    @attacker       = current_participation.ownerships.find(params[:id])
    @target         = @game.ownerships.find_by_territory_id(params[:target_id])
    
    @attack = @attacker.attack!(@target, attackers_count)
    
    publish_unit_losses
    publish_ownerhship_change if @attack.winner == @attacker
    
    render :nothing => true
  end
  
  
  def deploy
    render :nothing => true
  end
  
  
  private
  
  def publish_unit_losses
    Juggernaut.publish("games/#{@game.id}", {
      eventType: "UNITS_LOSSES",
      losses: [
        { unitsLoss: @attack.attacker_losses, territoryId: @attacker.territory_id },
        { unitsLoss: @attack.defender_losses, territoryId: @target.territory_id }
      ]
    })
  end
  
  
  def publish_ownerhship_change
    Juggernaut.publish("games/#{@game.id}", {
      eventType:   "OWNERSHIP_CHANGE",
      territoryId: @target.territory_id,
      oldOwner:    @target.participation,
      newOwner:    @attack.winner.participation
    })
  end
end
