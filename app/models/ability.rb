class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can [:update, :read], User
      can [:read, :create, :update, :destroy], Question
    end
  end
end
