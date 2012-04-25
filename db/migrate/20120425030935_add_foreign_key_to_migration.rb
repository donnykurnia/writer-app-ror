class AddForeignKeyToMigration < ActiveRecord::Migration
  def change
    add_foreign_key "milestones", "projects", :name => "milestones_project_id_fk"
    add_foreign_key "milestones", "users", :name => "milestones_writer_id_fk", :column => "writer_id"
  end
end
