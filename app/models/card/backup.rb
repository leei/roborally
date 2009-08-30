# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

#
# Card that backs the robot up.
#
class Card::Backup
  attr_reader :pri

  def initialize(pri)
    @pri = pri
  end
end
