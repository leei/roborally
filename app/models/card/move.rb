class Card::Move
  attr_reader :pri, :speed

  def initialize(pri, speed)
    @pri = pri
    @speed = speed
  end
end
