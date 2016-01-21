class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :question_id, :user_id, :created_at, :updated_at, :name, :question_user


  has_many :attachments
  has_many :comments

  def name
    object.user.email
  end

  def question_user
    object.question.user.id
  end
end
