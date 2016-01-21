FactoryGirl.define do

  factory :question do
    title "MyString MyString"
    body "MyText MyText"
    user
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end

end
