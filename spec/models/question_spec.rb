require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }



  # using only rspec, for example
  # it 'valid pres of title' do
  #   expect(Question.new(body: '123')).to_not be_valid
  # end
  # it 'valid pres of body' do
  #   expect(Question.new(title: '123')).to_not be_valid
  # end
end
