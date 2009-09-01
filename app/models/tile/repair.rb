# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

#
# A blank tile that has no effect.
#
class Tile::Repair
  @@instances = []

  attr_reader :power

  def self.instance(power = 1)
    inst = @@instances.detect{|i| i.power == power} and
      return inst
    inst = self.new(power)
    @@instances.push inst
    inst
  end

  def initialize(power)
    @power = power
  end
end
