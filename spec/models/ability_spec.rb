require 'rails_helper'

RSpec.describe Ability, type: :model do

  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }
    it { should be_able_to :read, User }
    it { should be_able_to :tags, Question }
    it { should be_able_to :unanswered, Question }
    it { should be_able_to :popular, Question }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:question) { create(:question, user: user) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, create(:question, user: user), user: user }
    it { should_not be_able_to :update, create(:question, user: other), user: user }
    it { should be_able_to :update, create(:answer, user: user), user: user }
    it { should_not be_able_to :update, create(:answer, user: other), user: user }
    it { should be_able_to :update, create(:comment, commentable: question, user: user), user: user }
    it { should_not be_able_to :update, create(:comment, commentable: question, user: other), user: user }

    it { should be_able_to :destroy, create(:question, user: user), user: user }
    it { should_not be_able_to :destroy, create(:question, user: other), user: user }
    it { should be_able_to :destroy, create(:answer, user: user), user: user }
    it { should_not be_able_to :destroy, create(:answer, user: other), user: user }
    it { should be_able_to :destroy, create(:comment, commentable: question, user: user), user: user }
    it { should_not be_able_to :destroy, create(:comment, commentable: question, user: other), user: user }

    it { should be_able_to :destroy, create(:attachment, attachmentable: question), user: user }
    it { should_not be_able_to :destroy, create(:attachment, attachmentable: create(:question, user: other)), user: user }

    it { should be_able_to :manage, user, id: user.id }
    it { should_not be_able_to :manage, :user, id: other.id }

    it { should be_able_to :vote_up, Vote }
    it { should be_able_to :vote_down, Vote }


    it { should be_able_to :accepted, create(:answer, question: question, user: other), user: user }
    it { should be_able_to :unaccepted, create(:answer, question: question, user: other), user: user }
  end

end