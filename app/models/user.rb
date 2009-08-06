class User < ActiveRecord::Base
  acts_as_authentic do |c|
    # optional configuration
    #c.add_acts_as_authentic_module :password
    #c.add_acts_as_authentic_module :email
  end

  has_one :player
  has_one :game, :through => :player
  has_one :hosted_game, :class_name => "Game", :foreign_key => "host_id"

  def new_game
    if player.nil?
      game = self.build_hosted_game
      game.add_player self
      game
    end
  end
end
