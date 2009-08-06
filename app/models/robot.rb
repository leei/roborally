class Robot < ActiveRecord::Base
  validates_length_of :name, :in => 3..32
end
