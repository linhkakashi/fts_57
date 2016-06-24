class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.is_admin?
      can :manage, [Subject, User, Question]
    else
      can :update, User
      can [:read, :create, :update, :destroy], Question
    end
  end
end
