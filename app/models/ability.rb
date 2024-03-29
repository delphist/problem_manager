class Ability
  include CanCan::Ability

  def initialize(user)
    can :accept, Task, director: user, completed: false
    can :decline, Task, director: user, completed_request: true, completed: false

    can :complete, Task, executor: user, completed_request: false, completed: false
    can :cancel, Task, executor: user, completed_request: true, completed: false

    if user.access_level? :read
      can :read, Problem
    end

    if user.access_level? :read_comment
      can :read, Problem
      can :create, Comment
    end

    if user.access_level? :full
      can :read, :all
      can :create, :all
      can :update, :all
      can :delete, :all
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
