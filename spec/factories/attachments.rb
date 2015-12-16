include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :attachment do
    file { File.new("#{Rails.root}/spec/factories/nginx.jpeg") }
    association :attachmentable
  end

end
