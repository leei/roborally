class Board < ActiveRecord::Base
end
class User < ActiveRecord::Base
end

class AddCreatorToBoards < ActiveRecord::Migration
  def self.up
    add_column :boards, :creator_id, :integer
    add_index :boards, :creator_id

    first_user = User.find(:first)

    Board.reset_column_information
    Board.update_all(["creator_id = ?", first_user.id])
  end

  def self.down
    remove_column :boards, :creator_id
  end
end
