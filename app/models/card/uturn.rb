# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

#
# Card that causes a U turn.
#
class Card::Uturn
  attr_reader :pri

  def initialize(pri)
    @pri = pri
  end
end
