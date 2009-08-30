# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

class Tile
  #
  # Find a tile, given its name.
  # This is used in the tile_layout building for a board
  def self.find_by_name(name)
    # Convert name to a Tile class and arguments
    args = name.to_s.split(/_/)
    klass = self.const_get(args.shift.to_s.camelize)
    klass.instance(*args) if klass
  end
end
