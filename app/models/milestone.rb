class Milestone < ActiveRecord::Base
  belongs_to :project, :inverse_of => :milestones
  belongs_to :writer, :class_name => "User",
    :foreign_key => "writer_id", :inverse_of => :milestones

  delegate :title, :to => :project, :prefix => true
  delegate :name, :to => :writer, :prefix => true

  STATUSES = ['open', 'finished', 'release requested', 'released', 'paid']

  attr_accessible :title, :description, :amount, :status, :writer_id, :payment_time, :payment_via

  before_destroy :check_deleteable
  before_create :set_status

  acts_as_paranoid

  validates :project, :presence => true
  validates :title, :presence => true
  validates :amount, :presence => true, :numericality => true
  validates :status, :on => :update, :inclusion => { :in => self::STATUSES,
    :message => "%{value} is not a valid status" }
  validates :payment_time, :allow_blank => true, :timeliness => {:type => :date}

  def to_s
    self.title
  end

  def deleteable?
    self.writer_id.nil? || self.status == 'open'
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

    def set_status
      self.status = 'open'
    end
end
