# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

#
# Card that moves the robot speed tiles.
#
class Card::Move
  attr_reader :pri, :speed

  def initialize(pri, speed)
    @pri = pri
    @speed = speed
  end
end
