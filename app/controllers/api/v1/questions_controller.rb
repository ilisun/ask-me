class Api::V1::QuestionsController < Api::V1::BaseController

  def index
    authorize! :read, current_resource_owner
    @questions = Question.all
    respond_with @questions
  end

end