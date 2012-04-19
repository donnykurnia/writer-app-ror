class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_index :users, :username
    add_column :users, :role, :string
    add_index :users, :role
    add_column :users, :full_name, :string
    add_column :users, :team_id, :integer
    add_index :users, :team_id
  end
end
