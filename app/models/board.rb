class Board < ActiveRecord::Base
  # Ensure that the name is unique
  validates_uniqueness_of :name

  # Ensure that max_players is [2..8]
  validates_numericality_of :max_players, :greater_than => 1, :less_than => 9

  # The layout_text describes the board's layout
  # It will consist of a NxN sequence of tile names
  # When constituting the layout, we walk through all tile names
  # in the layout_text and then produce the layout.
  serialize :layout_text

  #
  # The layout array for this board.
  #
  # It is derived from the layout_text by walking through the
  # layout_text arrays and finding a Tile with the same name
  # for each name in the layout_text.
  def layout
    return @layout if @layout

    bad_tiles = [] # The set of tile names that didn't work!
    @layout = []    # The 2D array of tiles
    for row in layout_text
      @layout.push(r = [])
      for tile_name in row
        tile = Tile.find_by_name(tile_name)
        r.push(tile)
        # Handle an error by remembering the tile name
        unless tile
          bad_tiles.push(tile_name) unless bad_tiles.include?(tile_name)
        end
      end
    end

    # If there was a problem raise the Error.
    unless bad_tiles.empty?
      @layout = nil
      raise Error("Bad tiles: %s" % bad_tiles.join(", "))
    end
    @layout
  end
end
