# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120425030935) do

  create_table "milestones", :force => true do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "description"
    t.decimal  "amount",       :precision => 11, :scale => 2
    t.string   "status"
    t.integer  "writer_id"
    t.datetime "payment_time"
    t.string   "payment_via"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.datetime "deleted_at"
  end

  add_index "milestones", ["deleted_at"], :name => "index_milestones_on_deleted_at"
  add_index "milestones", ["project_id"], :name => "index_milestones_on_project_id"
  add_index "milestones", ["status"], :name => "index_milestones_on_status"
  add_index "milestones", ["writer_id"], :name => "index_milestones_on_writer_id"

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "total_cost",  :precision => 11, :scale => 2
    t.integer  "team_id"
    t.string   "status"
    t.datetime "deadline"
    t.datetime "deleted_at"
    t.integer  "creator_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "projects", ["creator_id"], :name => "index_projects_on_creator_id"
  add_index "projects", ["deleted_at"], :name => "index_projects_on_deleted_at"
  add_index "projects", ["status"], :name => "index_projects_on_status"
  add_index "projects", ["team_id"], :name => "index_projects_on_team_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deleted_at"
  end

  add_index "teams", ["deleted_at"], :name => "index_teams_on_deleted_at"
  add_index "teams", ["name"], :name => "index_teams_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "role"
    t.string   "full_name"
    t.integer  "team_id"
    t.datetime "deleted_at"
  end

  add_index "users", ["deleted_at"], :name => "index_users_on_deleted_at"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role"], :name => "index_users_on_role"
  add_index "users", ["team_id"], :name => "index_users_on_team_id"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  add_foreign_key "milestones", "projects", :name => "milestones_project_id_fk"
  add_foreign_key "milestones", "users", :name => "milestones_writer_id_fk", :column => "writer_id"

  add_foreign_key "projects", "teams", :name => "projects_team_id_fk"
  add_foreign_key "projects", "users", :name => "projects_creator_id_fk", :column => "creator_id"

  add_foreign_key "users", "teams", :name => "users_team_id_fk"

end
