require 'rails_helper'

RSpec.describe Vote, type: :model do

  subject {build(:vote, votable: build(:question))}

  describe 'association of Vote model' do
    it { should belong_to :user }
    it { should belong_to :votable }
  end

  describe 'reputation' do
    context 'for question' do
      context 'after voting up' do
        let(:value) { 2 }

        it_behaves_like 'Change Reputationable'
      end

      context 'after voting down' do
        let(:value) { -2 }
        before { subject.value = -1 }

        it_behaves_like 'Change Reputationable'
      end
    end

    context 'for answer' do
      before do
        subject.votable = create(:answer)
      end

      context 'after voting up' do
        let(:value) { 1 }

        it_behaves_like 'Change Reputationable'
      end

      context 'after voting down' do
        let(:value) { -1 }
        before { subject.value = -1 }

        it_behaves_like 'Change Reputationable'
      end
    end
  end

end
