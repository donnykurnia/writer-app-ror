class AddForeignKeyInProjects < ActiveRecord::Migration
  def change
    add_foreign_key "projects", "users", :name => "projects_creator_id_fk", :column => "creator_id"
    add_foreign_key "projects", "teams", :name => "projects_team_id_fk"
  end
end
