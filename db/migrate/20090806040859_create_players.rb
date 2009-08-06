class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer :game_id
      t.integer :user_id
      t.integer :robot_id
      t.integer :x
      t.integer :y
      t.string :dir, :limit => 1, :default => "n"
      t.integer :lives, :default => 3
      t.integer :damage, :default => 0
      t.integer :flags, :default => 0

      t.timestamps
    end

    add_index :players, :game_id
    add_index :players, :user_id
    add_index :players, :robot_id
  end

  def self.down
    drop_table :players
  end
end
