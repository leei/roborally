#
# The gears, which rotate a robot.  There are two gear_l and gear_r for
# rotating left and right.
#
class Tile::Gear
  @@instances = []

  attr_reader :dir

  def self.instance(dir = "l")
    inst = @@instances.detect{|i| i.dir == dir} and
      return inst
    inst = self.new(dir)
    @@instances.push inst
    inst
  end

  def initialize(dir)
    @dir = dir
  end
end
