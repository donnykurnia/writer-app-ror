class Project < ActiveRecord::Base
  attr_accessible :title, :description, :status, :deadline, :creator_id, :team_id, :total_cost

  belongs_to :team, :inverse_of => :projects
  belongs_to :creator, :class_name => "User",
    :foreign_key => "creator_id", :inverse_of => :projects

  acts_as_paranoid
end
