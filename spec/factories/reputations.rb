FactoryGirl.define do
  factory :reputation do
    value 1
    operation "MyString"
    reputationable_id 1
    reputationable_type "MyString"
    user nil
  end

end
