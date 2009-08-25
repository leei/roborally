class Board < ActiveRecord::Base
  # Each board has a creator.
  belongs_to :creator, :class_name => "User"

  # Ensure that the name is unique
  validates_uniqueness_of :name

  # Ensure that it is at least 3 characters long.
  validates_length_of :name, :in => 3..32

  # Ensure that max_players is [2..8]
  validates_numericality_of :max_players, :greater_than => 1, :less_than => 9

  # Ensure that we are properly marking the creator
  validates_presence_of :creator_id

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
  # A user can edit if he is the creator.
  #
  def can_edit?(user)
    user && self.creator_id == user.id
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
  # Show the layout text in a JSON string.
  #
  def layout_text_json
    self.layout_text.to_json
  end

  #
  # Show the layout text in a JSON string.
  #
  def layout_text_json=(text)
    self.layout_text = JSON.parse(text)
  end

  #
  # How many rows are there in the layout?
  #
  def rows
    layout_text.blank? ? 12 : layout.size
  end

  #
  # How many columns are there in the layout?
  #
  def columns
    layout_text.blank? ? 12 : layout[0].size
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
