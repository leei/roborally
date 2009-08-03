class Tile
  #
  # Find a tile, given its name.
  # This is used in the tile_layout building for a board
  def self.find_by_name(name)
    # Convert name to a Tile class
    klass = self.const_get(name.to_s.camelize)
    klass.instance if klass
  end
end
