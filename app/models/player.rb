# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :robot
  belongs_to :game
end
