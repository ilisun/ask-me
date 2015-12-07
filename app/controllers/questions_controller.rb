class QuestionsController < ApplicationController

  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
  end

  def new
    @question = Question.new
  end

  def edit
    if current_user != @question.user
      flash[:alert] = 'You are not the author of this question!'
      redirect_to questions_path
    end
  end

  def create
    @question = current_user.questions.create(questions_params)

    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      flash[:alert] = 'Your question is incorrect.'
      render :new
    end
  end

  def update
    if @question.update(questions_params)
      flash[:notice] = 'Your question successfully fixed.'
      redirect_to @question
    else
      flash[:alert] = 'Your question is incorrect.'
      render :edit
    end
  end

  def destroy
    if current_user == @question.user
      @question.destroy
      flash[:notice] = 'Your question is successfully deleted.'
      redirect_to questions_path
    else
      flash[:alert] = 'You are not the author of this question!'
      redirect_to questions_path
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body)
  end
end
