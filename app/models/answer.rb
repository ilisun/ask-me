class Answer < ActiveRecord::Base

  default_scope { order(:created_at) }

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable


  validates :body, presence: true
  validates :body, length: { minimum: 10 }, allow_blank: true

  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }

  def show_title
    "A: #{self.question.title}"
  end

  def show_object
    self.question
  end

end
