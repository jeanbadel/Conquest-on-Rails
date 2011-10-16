class Participation < ActiveRecord::Base
  default_value_for :units_count, Game::UNITS_COUNT_AT_BEGINNING
  
  belongs_to :game, :counter_cache => true
  belongs_to :user
  has_many :ownerships
  
  default_value_for :alive, true
  
  
  # Dispatch remaining units in owned territories.
  # Used when the user didn't do it himself during deployment.
  def dispatch_remaining_units!
    units_count.times do
      ownerships.sample.deploy_units!(1)
    end
  end
end
