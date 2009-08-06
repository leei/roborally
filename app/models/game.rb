class Game < ActiveRecord::Base
  #-------------
  # associations

  belongs_to :host, :class_name => "User"
  has_many :players

  #------------
  # validations

  # must be associated with a board
  validates_presence_of :board_id

  validates_presence_of :host_id

  #-----------------
  # instance methods

  #
  # Add a new player to this game.  Only succeeds if we haven't yet reached
  # max_players.
  #
  def add_player(user)
    if self.players.count < self.max_players
      self.players.build(:user => user)
    end
  end
end
