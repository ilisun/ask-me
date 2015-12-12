require 'rails_helper'

RSpec.describe Answer, type: :model do

  describe 'validation of Question model' do
    it { should validate_presence_of :body }
    it { should validate_length_of(:body).is_at_least(10) }
  end

  describe 'аssociation of Question model' do
    it { should belong_to :question }
    it { should belong_to(:user)}
    it { should have_many(:attachments)  }

    it { should accept_nested_attributes_for(:attachments)  }
  end

end
