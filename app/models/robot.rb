# Copyright 2009, Lee Iverson and Maxwell Iverson
# See file COPYRIGHT for terms and conditions

class Robot < ActiveRecord::Base
  validates_length_of :name, :in => 3..32
end
