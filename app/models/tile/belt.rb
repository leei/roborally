# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

#
# A Belt tile that moves the robot in the given direction and speed.
#
class Tile::Belt
  @@instances = []

  attr_reader :dir, :speed

  def self.instance(dir = "n", speed = 1)
    inst = @@instances.detect{|i| i.dir == dir && i.speed == speed} and
      return inst
    inst = self.new(dir, speed)
    @@instances.push inst
    inst
  end

  def initialize(dir, speed)
    @dir = dir
    @speed = speed
  end
end
