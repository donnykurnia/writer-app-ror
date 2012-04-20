class Team < ActiveRecord::Base
  attr_accessible :name

  has_many :users, :inverse_of => :team
  has_many :projects, :inverse_of => :team

  acts_as_paranoid

  #validates :name, :uniqueness => true

  before_destroy :check_deleteable

  def deleteable?
    self.users.count == 0 && self.id > 1
  end

  protected

    def check_deleteable
      self.deleteable?
    end

end
