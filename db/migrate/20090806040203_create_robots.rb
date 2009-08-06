class CreateRobots < ActiveRecord::Migration
  def self.up
    create_table :robots do |t|
      t.string :name, :limit => 32
      t.string :sprite, :string

      t.timestamps
    end

    add_index :robots, :name, :unique => true
  end

  def self.down
    drop_table :robots
  end
end
