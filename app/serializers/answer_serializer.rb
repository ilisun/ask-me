include ActionView::Helpers::TextHelper

class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :body_html, :question_id, :user_id, :created_at, :updated_at, :name, :question_user


  has_many :attachments
  has_many :comments

  def name
    object.user.email
  end

  def body_html
    simple_format(object.body, {}, :sanitize => false)
  end

  def question_user
    object.question.user.id
  end
end
