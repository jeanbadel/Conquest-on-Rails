class DeploymentsController < ApplicationController
  def create
    units_count = params[:units_count].to_i
    ownership   = current_participation.ownerships.find_by_territory_id(params[:territory_id])
    deployment  = Deployment.new(ownership, units_count).perform!

    Juggernaut.publish(
      "games/#{ownership.game.id}",
      eventType:         "deploymentOccured",
      phase:             deployment.game.phase,
      unitsCount:        deployment.units_count,
      targetTerritoryId: deployment.territory.id
    )

    render json: true
  end
end
