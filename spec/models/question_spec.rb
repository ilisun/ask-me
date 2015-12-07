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
    it { should have_many(:answers).dependent(:destroy)  }
    it { should belong_to(:user)}
  end



end
