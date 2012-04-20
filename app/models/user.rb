class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :full_name, :role, :team_id, :team_attributes
  attr_accessor :login

  belongs_to :team, :inverse_of => :users
  has_many :projects, :foreign_key => "creator_id", :inverse_of => :creator

  accepts_nested_attributes_for :team

  delegate :name, :to => :team, :prefix => true, :allow_nil => true

  acts_as_paranoid

  validates :username, :presence => true

  before_save :set_default_role

  def name
    self.full_name || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end

  def update_attributes(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)

      result = super(params, *options)
      clean_up_passwords
      result
    else
      super(params, *options)
    end
  end

  protected

    # If you need to validate the associated record, you can add a method like this:
    #     validate_associated_record_for_team
    def autosave_associated_records_for_team
      if team.name.blank?
        self.team_id = 1
      else
        # Find or create the team by name
        self.team = Team.find_or_create_by_name(team.name)
      end
    end

    def set_default_role
      self.role = 'writer' if self.role.blank?
    end

end
