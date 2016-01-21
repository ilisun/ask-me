class VotesController < ApplicationController

  before_action :authenticate_user!
  before_action :load_parent, only: [:vote_up, :vote_down]

  respond_to :json
  authorize_resource

  def vote_up
    check_vote(1, -1)
    respond_with(@vote, json: @vote)
  end

  def vote_down
    check_vote(-1, 1)
    respond_with(@vote, json: @vote)
  end

  private

  def vote_update
    @parent.update_attributes(votes_sum: @parent.votes.sum("value"))
  end

  def load_parent
    @parent = case params[:class]
                when 'Question' then Question.find(params[:id])
                when 'Answer' then Answer.find(params[:id])
              end
  end

  def check_vote(old_value, new_value)
    @vote = @parent.votes.where(user_id: current_user).first
    if !@vote.present?
      @vote = @parent.votes.create(user: current_user, value: old_value)
      vote_update
    elsif @vote.value == new_value
      @vote.update_attributes(value: old_value)
      vote_update
    end
  end

end
