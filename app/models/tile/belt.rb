# To change this template, choose Tools | Templates
# and open the template in the editor.

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
