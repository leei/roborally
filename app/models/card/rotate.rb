# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

#
# Card that rotates a robot on some direction
#
class Card::Rotate
  attr_reader :pri, :dir

  def initialize(pri, dir)
    @pri = pri
    @dir = dir
  end
end
