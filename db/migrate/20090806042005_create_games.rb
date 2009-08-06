class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.boolean :started, :default => false
      t.integer :host_id
      t.integer :max_players, :default => 8
      t.integer :board_id

      t.timestamps
    end

    add_index :games, :host_id
    add_index :games, :board_id
  end

  def self.down
    drop_table :games
  end
end
