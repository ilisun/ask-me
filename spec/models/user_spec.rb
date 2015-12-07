require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'аssociation of User model' do
    it {should have_many(:questions)}
    it {should have_many(:answers)}
  end

end
