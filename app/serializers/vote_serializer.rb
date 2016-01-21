class VoteSerializer < ActiveModel::Serializer
  attributes :id, :value, :votable_id, :votable_type, :user_id, :votes_sum

  def votes_sum
    load_parent.votes_sum
  end

  def load_parent
    votable_type == "Question" ? Question.find(object.votable_id) : Answer.find(object.votable_id)
  end

end