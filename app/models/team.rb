class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users, :inverse_of => :team
  has_many :projects, :inverse_of => :team

  acts_as_paranoid

  validates :name, :presence => true
end
