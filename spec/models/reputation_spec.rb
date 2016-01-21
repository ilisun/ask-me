require 'rails_helper'

RSpec.describe Reputation, :type => :model do

  describe 'association of Reputation model' do
    it { should belong_to(:user) }
    it { should belong_to(:reputationable) }
  end

  describe '#increase' do
    let(:user) {create(:user)}
    let(:question) {create(:question, user: user)}
    let(:answer) {create(:answer, question: question)}
    let(:rep) { build(:reputation, user: user, reputationable: answer) }

    context 'when user creates first answer' do
      context 'and he is not author of question' do
        before { rep.operation = "first_answer_to_question" }
        let(:value) { 1 }

        it_behaves_like 'Creating Reputationable'
      end

      context 'and he is author of question' do
        before { rep.operation = "first_answer_to_your_question" }
        let(:value) { 3 }

        it_behaves_like 'Creating Reputationable'
      end
    end

    context 'when user creates answer not the first' do
      before { create(:answer, question: question) }

      context 'and he is author of question' do
        before { rep.operation = "answer_to_your_question" }
        let(:value) { 2 }

        it_behaves_like 'Creating Reputationable'
      end

      context 'and he is not author of question' do

        before { rep.operation = "answer_to_question" }
        let(:value) { 1 }

        it_behaves_like 'Creating Reputationable'
      end
    end

    context 'when answer of user is accepted' do
      before { rep.operation = "accepted_answer" }
      let(:value) { 3 }

      it_behaves_like 'Creating Reputationable'
    end

    context 'when answer' do
      context 'is voted up' do
        before { rep.operation = "vote_up_answer"}
        let(:value) { 1 }

        it_behaves_like 'Creating Reputationable'
      end

      context 'is voted down' do
        before { rep.operation = "vote_down_answer"}
        let(:value) { -1 }

        it_behaves_like 'Creating Reputationable'
      end
    end

    context 'when question' do
      context 'is voted up' do
        before { rep.operation = "vote_up_question"}
        let(:value) { 2 }

        it_behaves_like 'Creating Reputationable'
      end

      context 'is voted down' do
        before { rep.operation = "vote_down_question"}
        let(:value) { -2 }

        it_behaves_like 'Creating Reputationable'
      end
    end

  end

end