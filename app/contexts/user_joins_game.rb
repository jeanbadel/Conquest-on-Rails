class UserJoinsGame
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
  end


  def process
    raise GameIsRunning   if game.state == Game::RUNNING
    raise GameIsFullError if game.full?

    game.participations.create(user: user, position: position).tap do
      game.start if game.full?
    end
  end


  def position
    game.participations.count || 0
  end


  class GameIsFullError < StandardError; end
  class GameIsRunning   < StandardError; end
end
