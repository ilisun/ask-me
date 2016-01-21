class Question < ActiveRecord::Base

  default_scope { order(created_at: :desc) }

  scope :unanswered, -> { joins('LEFT JOIN answers ON questions.id = answers.question_id').where('answers.question_id IS NULL').uniq }
  scope :popular, -> { unscoped.order(votes_sum: :desc) }

  acts_as_taggable

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, :body, length: { minimum: 10 }, allow_blank: true
  validates :title, length: { maximum: 250 }

  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }

  def show_title
    "Q: #{title}"
  end

  def show_object
    self
  end

end
