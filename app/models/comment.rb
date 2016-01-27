class Comment < ActiveRecord::Base

  default_scope { order(created_at: :asc) }

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true
end
