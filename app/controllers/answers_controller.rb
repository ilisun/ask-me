class AnswersController < ApplicationController

  before_action :load_question, only: [:create, :update, :destroy]
  before_action :load_answer, only: [:update, :destroy]
  before_action :authenticate_user!

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:notice] = 'Your answer successfully created.'
      # redirect_to question_path(@question)
    else
      flash[:error] = 'ERROR: ' + @answer.errors.full_messages.to_sentence
      # render "questions/show"
    end

  end

  def update

    if @answer.update(answer_params)
      flash[:notice] = 'Your answer successfully fixed.'
      # redirect_to question_path(@question)
    else
      flash[:alert] = 'Your answer is incorrect.'
      # render 'edit'
    end
  end

  def destroy
    if current_user == @answer.user
      @answer.destroy
      redirect_to question_path(@question)
    else
      flash[:alert] = 'You are not the author of this answer!'
      redirect_to questions_path
    end
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

end
