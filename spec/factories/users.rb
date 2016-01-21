FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "test#{n}@test.ru" }
    password '12345678'
    password_confirmation '12345678'

  end

end
