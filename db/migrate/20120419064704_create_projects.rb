class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.decimal :total_cost, :precision => 11, :scale => 2
      t.integer :team_id
      t.string :status
      t.datetime :deadline
      t.datetime :deleted_at
      t.integer :creator_id

      t.timestamps
    end
    add_index :projects, :team_id
    add_index :projects, :status
    add_index :projects, :deleted_at
    add_index :projects, :creator_id
  end
end
