class AddIndexForDeletedAtInUsers < ActiveRecord::Migration
  def change
    add_index "users", ["deleted_at"]
  end
end
