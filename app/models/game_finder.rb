class GameFinder
  attr_reader :user, :available_games

  def initialize(user, available_games)
    @user            = user
    @available_games = available_games
  end


  def search
    available_games.sample
  end


  def available_games_for_user
    available_games.reject do |game|
      game.users.include?(user)
    end
  end
end
