FactoryGirl.define do
  factory :vote do
    value 1
    user
    association :votable
  end

end
