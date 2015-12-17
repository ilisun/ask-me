class Answer < ActiveRecord::Base

  default_scope { order(:created_at) }

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { minimum: 10 }, allow_blank: true

  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }

end
