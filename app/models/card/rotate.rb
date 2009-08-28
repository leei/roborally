class Card::Rotate
  attr_reader :pri, :dir

  def initialize(pri, dir)
    @pri = pri
    @dir = dir
  end
end
