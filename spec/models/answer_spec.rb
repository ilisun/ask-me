require 'rails_helper'

RSpec.describe Answer, type: :model do

  subject { build(:answer) }

  describe 'validation of Answer model' do
    it { should validate_presence_of :body }
    it { should validate_length_of(:body).is_at_least(10) }
  end

  describe 'association of Answer model' do
    it { should belong_to :question }
    it { should belong_to :user }
    it { should have_many :attachments }
    it { should have_many :comments }
    it { should have_many :votes }

    it { should accept_nested_attributes_for :attachments }
  end

  describe 'show_title and show_object' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:answer) {create(:answer, question: question)}

    it 'show_title' do
      expect(answer.show_title).to eq "A: MyString MyString"
    end

    it 'show_object' do
      expect(answer.show_object).to eq question
    end
  end

  describe 'reputation' do
    let!(:user) {create(:user)}
    let!(:question) {create(:question, user: user)}
    let(:answer) {create(:answer, question: question, user: user)}

    context 'after creating answer' do
      context 'first_answer_to_question' do
        let(:value) { 1 }

        it_behaves_like 'Change Reputationable'
      end

      context 'first answer to your question' do
        subject { build(:answer, question: question, user: user)}
        let(:value) { 3 }

        it_behaves_like 'Change Reputationable'
      end

      context 'not first answer to your question' do
        before {create(:answer, question: question)}
        subject {build(:answer, question: question, user: user)}
        let(:value) { 2 }

        it_behaves_like 'Change Reputationable'
      end

      context 'not first answer' do
        before {create(:answer, question: question)}
        subject {build(:answer, question: question)}
        let(:value) { 1 }

        it_behaves_like 'Change Reputationable'
      end
    end
  end

end
