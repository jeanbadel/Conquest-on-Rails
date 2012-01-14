class Deployment
  attr_reader :ownership, :participation, :territory, :game, :units_count


  def initialize(ownership, units_count)
    @ownership     = ownership
    @participation = ownership.participation
    @territory     = ownership.territory
    @game          = ownership.game
    @units_count   = units_count
  end


  def validate!
    raise NotEnoughUnitsToDeploy if @participation.units_count < units_count
    raise TooDeadToDeploy unless @participation.alive?
    raise NotActivePlayer unless @participation.active?
  end


  def perform!
    validate!
    deploy_unit!
    try_to_start_next_phase!

    self
  end


  def deploy_unit!
    Game.transaction do
      ownership.increment!(:units_count, units_count)
      participation.decrement!(:units_count, units_count)
    end
  end


  def try_to_start_next_phase!
    game.next_phase! if participation.units_count == 0
  end


  class NotEnoughUnitsToDeploy < StandardError; end
  class TooDeadToDeploy        < StandardError; end
  class NotActivePlayer        < StandardError; end
end
