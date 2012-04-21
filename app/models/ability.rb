class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :read, :update, :to => :examine

    user ||= User.new # guest user (not logged in)

    can :update, User, :id => user.id
    can :read, Team, :id => user.team_id
    #can :read, Message, :readable_by => user
    #can :create, Message

    if user.admin?
      can :manage, :all
      cannot :destroy, User, :id => user.id
      cannot :destroy, Team do |team|
        ! team.deleteable?
      end
      can :assign_roles, User
    elsif user.manager?
      can :read, User, :team_id => user.team_id
      can :manage, Project, :team_id => user.team_id
      can :update, Team, :id => user.team_id
      #can :manage, Milestone do |milestone| milestone.team_id == user.team_id end
      #can :examine, Bid do |bid| bid.team_id == user.team_id end
      #can :read, Report do |report| report.team_id == user.team_id end
    elsif user.writer?
      can :read, User, :id => user.id
      can :read, Project, :team_id => user.team_id
      #can :read, Milestone do |milestone| milestone.team_id == user.team_id end
      #can :manage, Bid, :user_id => user.id
      #cannot :destroy, Bid
      #can :manage, Report, :user_id => user.id
      #cannot :destroy, Report
    end

    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
