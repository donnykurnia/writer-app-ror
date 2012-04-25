class Milestone < ActiveRecord::Base
  belongs_to :project, :inverse_of => :milestones
  belongs_to :writer, :class_name => "User",
    :foreign_key => "writer_id", :inverse_of => :milestones

  delegate :title, :to => :project, :prefix => true
  delegate :name, :to => :writer, :prefix => true

  STATUSES = ['open', 'finished', 'release request', 'released', 'paid']

  attr_accessible :title, :description, :amount, :status, :writer_id, :payment_time, :payment_via

  acts_as_paranoid
end
