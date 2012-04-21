class Project < ActiveRecord::Base
  attr_accessible :title, :description, :status, :deadline, :creator_id, :team_id, :total_cost

  STATUSES = ['open', 'in progress', 'finished', 'expired']

  belongs_to :team, :inverse_of => :projects
  belongs_to :creator, :class_name => "User",
    :foreign_key => "creator_id", :inverse_of => :projects

  delegate :name, :to => :creator, :prefix => true
  delegate :name, :to => :team, :prefix => true

  before_destroy :check_deleteable

  acts_as_paranoid

  validates :title, :presence => true
  validates :description, :presence => true
  validates :total_cost, :presence => true, :numericality => true
  validates :status, :inclusion => { :in => self::STATUSES,
    :message => "%{value} is not a valid status" }
  validates :deadline, :timeliness => {:type => :date}

  def deleteable?
    true
    #self.bids.count == 0
  end

  protected

    def check_deleteable
      self.deleteable?
    end

end
