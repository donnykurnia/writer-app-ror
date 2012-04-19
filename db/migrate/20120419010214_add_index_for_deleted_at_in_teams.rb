class AddIndexForDeletedAtInTeams < ActiveRecord::Migration
  def change
    add_index "teams", ["deleted_at"]
  end
end
