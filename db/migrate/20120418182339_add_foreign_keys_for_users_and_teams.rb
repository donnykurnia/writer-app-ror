class AddForeignKeysForUsersAndTeams < ActiveRecord::Migration
  def change
    add_foreign_key "users", "teams", :name => "users_team_id_fk"
  end
end
