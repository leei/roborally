class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.string :name, :size => 32
      t.text :description
      t.text :layout_text
      t.integer :max_players
      t.timestamps
    end

    add_index :boards, :name, :unique => true
  end

  def self.down
    drop_table :boards
  end
end
