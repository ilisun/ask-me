class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  validates :body, length: { minimum: 10 }, allow_blank: true


end
