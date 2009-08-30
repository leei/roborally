# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

#
# A Turn is a kind of belt that rotates the robot as it transports.
#
class Tile::Turn
  @@instances = []

  attr_reader :dir, :turn

  def self.instance(dir = "n", turn = "l", speed = 1)
    inst = @@instances.detect{|i|
      i.dir == dir && i.turn == turn && i.speed = speed
    } and return inst
    inst = self.new(dir, turn, speed)
    @@instances.push inst
    inst
  end

  def initialize(dir, turn, speed)
    @dir = dir
    @turn = turn
    @speed = speed
  end
end
