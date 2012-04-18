class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users

  acts_as_paranoid
end
