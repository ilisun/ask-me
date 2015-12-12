class Question < ActiveRecord::Base

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, :body, length: { minimum: 10 }, allow_blank: true
  validates :title, length: { maximum: 250 }

  accepts_nested_attributes_for :attachments
end
