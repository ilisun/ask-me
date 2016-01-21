class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :commentable_id, :commentable_type, :user_id, :created_at, :updated_at, :name, :user_avatar

  def name
    object.user.email if object.user
  end

  def user_avatar
    if object.user && object.user.avatar?
      object.user.avatar.url(:thumb)
    else
      "/assets/no_avatar.png"
    end
  end

end