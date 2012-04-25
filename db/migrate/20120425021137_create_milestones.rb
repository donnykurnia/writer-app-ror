class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.references :project
      t.string :title
      t.text :description
      t.decimal :amount, :precision => 11, :scale => 2
      t.string :status
      t.integer :writer_id
      t.datetime :payment_time
      t.string :payment_via

      t.timestamps
    end
    add_index :milestones, :project_id
    add_index :milestones, :status
    add_index :milestones, :writer_id
  end
end
