require 'rails_helper'

RSpec.describe Question, type: :model do

  describe 'validation of Question model' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :body }
    it { should validate_length_of(:body).is_at_least(10) }
    it { should validate_length_of(:title).is_at_least(10) }
    it { should validate_length_of(:title).is_at_most(250) }
  end

  describe 'аssociation of Question model' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:attachments) }
    it { should have_many(:comments) }
    it { should have_many(:votes) }
    it { should belong_to(:user) }

    it { should accept_nested_attributes_for(:attachments)  }
  end

  describe 'show_title and show_object' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }

    it 'show_title' do
      expect(question.show_title).to eq "Q: MyString MyString"
    end

    it 'show_object' do
      expect(question.show_object).to eq question
    end
  end

end
