class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
    can [:tags, :unanswered, :popular], Question
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can [:edit, :update, :destroy], [Question, Answer, Comment], user: user
    can :destroy, Attachment, attachmentable: { user: user }
    can :manage, User, id: user.id
    can [:vote_up, :vote_down], Vote
    can [:accepted, :unaccepted], Answer, question: { user: user }
  end

end
