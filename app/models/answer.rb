class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { minimum: 10 }, allow_blank: true

  accepts_nested_attributes_for :attachments, allow_destroy: true

end
