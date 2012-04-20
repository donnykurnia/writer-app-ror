class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login, :full_name, :role, :team_id, :team_attributes
  attr_accessor :login

  belongs_to :team
  has_many :projects

  accepts_nested_attributes_for :team

  delegate :name, :to => :team, :prefix => true

  acts_as_paranoid

  validates :username, :presence => true

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

end
