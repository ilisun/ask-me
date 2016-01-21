class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:update, :destroy, :edit, :accepted, :unaccepted]

  respond_to :json
  authorize_resource


  def create
    respond_with(@answer = @question.answers.create(answer_params.merge(user: current_user)))
  end

  def edit
    respond_with(@answer)
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer, json: @answer)
  end

  def destroy
    @answer.destroy
    respond_with(@answer, json: @answer)
  end

  def accepted
    @answer.update_attributes(accepted: true)
    Reputation.new(reputationable: @answer, user: @answer.user, operation: 'accepted_answer').increase
    render nothing: true
  end

  def unaccepted
    @answer.update_attributes(accepted: false)
    render nothing: true
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file, :id, :_destroy])
  end

end
