require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation of Question model' do
    it { should validate_presence_of :body }
  end

  describe 'аssociation of Question model' do
    it { should belong_to(:user)}
    it { should belong_to :commentable }
  end
end
