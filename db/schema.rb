# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090824224607) do

  create_table "boards", :force => true do |t|
    t.string   "name",        :limit => 32
    t.text     "description"
    t.text     "layout_text"
    t.integer  "max_players"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  add_index "boards", ["creator_id"], :name => "index_boards_on_creator_id"
  add_index "boards", ["name"], :name => "index_boards_on_name", :unique => true

  create_table "games", :force => true do |t|
    t.boolean  "started",     :default => false
    t.integer  "host_id"
    t.integer  "max_players", :default => 8
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["board_id"], :name => "index_games_on_board_id"
  add_index "games", ["host_id"], :name => "index_games_on_host_id"

  create_table "players", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.integer  "robot_id"
    t.integer  "x"
    t.integer  "y"
    t.string   "dir",        :limit => 1, :default => "n"
    t.integer  "lives",                   :default => 3
    t.integer  "damage",                  :default => 0
    t.integer  "flags",                   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["game_id"], :name => "index_players_on_game_id"
  add_index "players", ["robot_id"], :name => "index_players_on_robot_id"
  add_index "players", ["user_id"], :name => "index_players_on_user_id"

  create_table "robots", :force => true do |t|
    t.string   "name",       :limit => 32
    t.string   "sprite"
    t.string   "string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "robots", ["name"], :name => "index_robots_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "login",                             :null => false
    t.string   "email",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.string   "perishable_token",                  :null => false
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

end
