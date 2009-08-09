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

  #--------------------------------------------------------------------------
  # instance methods

  #
  # Refer to boards by name throughout the interface.
  #
  def to_param
    "#{id}-#{name.parameterize}"
  end

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

  #
  # Reset the layout so that it will be rebuilt from layout_text
  private
  def reset_layout
    @layout = nil
  end

  # Replace current layout with a blank layout of [rows]x[cols]
  public
  def clear_layout(cols, rows)
    reset_layout
    row = (1..cols).collect { :blank }
    self.layout_text = (1..rows).collect { row.dup }
    self.layout
  end

  # Set the tile at col,row to the Tile so named
  def set_tile(col, row, name)
    reset_layout
    layout_text[col][row] = name
  end

  #--------------------------------------------------------------------------
  # class methods

  puts "this is awesome!!!"
end
