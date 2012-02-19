class UserJoinsGame
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
  end


  def process
    raise GameIsRunning   if game.state == Game::RUNNING
    raise GameIsFullError if game.full?

    game.users << user
  end


  class GameIsFullError < StandardError; end
  class GameIsRunning   < StandardError; end
end
