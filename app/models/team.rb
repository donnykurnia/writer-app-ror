class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users
  has_many :projects

  acts_as_paranoid
end
