class Project < ActiveRecord::Base
  belongs_to :team, :inverse_of => :projects
  belongs_to :creator, :class_name => "User",
    :foreign_key => "creator_id", :inverse_of => :projects
  has_many :milestones, :inverse_of => :project, :dependent => :destroy, :order => "id ASC"

  accepts_nested_attributes_for :milestones, :allow_destroy => true

  delegate :name, :to => :creator, :prefix => true
  delegate :name, :to => :team, :prefix => true
  delegate :writers, :to => :team, :prefix => true

  STATUSES = ['open', 'in progress', 'finished', 'expired']

  attr_accessible :title, :description, :status, :deadline, :creator_id, :team_id, :total_cost, :milestones_attributes

  before_destroy :check_deleteable
  before_create :set_team

  acts_as_paranoid

  validates :title, :presence => true
  validates :description, :presence => true
  validates :total_cost, :presence => true, :numericality => true
  validates :status, :inclusion => { :in => self::STATUSES,
    :message => "%{value} is not a valid status" }
  validates :deadline, :timeliness => {:type => :date}

  paginates_per 20

  def to_s
    self.title
  end

  def deleteable?
    true
    #self.bids.count == 0
  end

  protected

    def check_deleteable
      if self.deleteable?
        true
      else
        errors[:base] << "Delete failed"
        false
      end
    end

    def set_team
      self.team_id = self.creator.team_id
    end

end
