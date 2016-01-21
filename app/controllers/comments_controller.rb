class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parent, only: [:create, :new]
  before_action :load_comment, only: [:destroy]

  respond_to :json
  authorize_resource

  def create
    respond_with(@comment = @parent.comments.create(comment_params.merge(user: current_user)))
  end

  def new
    respond_with(@comment = @parent.comments.new)
  end

  def destroy
    @comment.destroy
    respond_with(@comment, json: @comment)
  end

  private

  def load_parent
    @parent = Question.find(params[:question_id]) if params[:question_id]
    @parent ||= Answer.find(params[:answer_id])
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def interpolation_options
    { alert: @comment.errors.full_messages.to_sentence }
  end

end
