class AddDeletedAtToMilestone < ActiveRecord::Migration
  def change
    add_column :milestones, :deleted_at, :datetime
    add_index :milestones, :deleted_at
  end
end
