FactoryGirl.define do
  factory :comment do
    body "My comment My comment"
    user
    association :commentable
  end

  factory :invalid_comment, class: "Comment" do
    body nil
  end

end
