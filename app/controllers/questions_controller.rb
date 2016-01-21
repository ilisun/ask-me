class QuestionsController < ApplicationController

  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :tags]
  before_action :build_answer, only: :show

  respond_to :html
  authorize_resource

  def index
    if params[:tag]
      respond_with(@questions = Question.tagged_with(params[:tag]).page(params[:page]).per(5))
    else
      respond_with(@questions = Question.all.page(params[:page]).per(5))
    end
  end

  def unanswered
    @questions = Question.unanswered.page(params[:page]).per(5)
    render :index
  end

  def popular
    @questions = Question.popular.page(params[:page]).per(5)
    render :index
  end

  def show
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
    @question.attachments.build
    respond_with(@question)
  end

  def create
    respond_with(@question = current_user.questions.create(questions_params))
  end

  def update
    @question.update(questions_params)
    respond_with(@question)
  end

  def destroy
    respond_with(@question.destroy)
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body, :tag_list, attachments_attributes: [:file, :id, :_destroy])
  end

  def build_answer
    @answer = @question.answers.build
  end

  def interpolation_options
    { alert: @question.errors.full_messages.to_sentence }
  end

end
