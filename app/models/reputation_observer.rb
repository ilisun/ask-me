class ReputationObserver < ActiveRecord::Observer
  observe :answer, :vote

  def after_create(record)
    @record = record.reload
    Reputation.new(reputationable: @record, user: user, operation: define_operation).increase
  end

  def after_update(record)
    @record = record.reload
    Reputation.new(reputationable: @record, user: user, operation: define_operation).increase if @record.is_a?(Vote)
  end

  private

  def define_operation
    if @record.is_a?(Answer)
      if @record.user == @record.question.user
        if @record.question.answers.count == 1
          'first_answer_to_your_question'
        else
          'answer_to_your_question'
        end
      elsif @record.question.answers.count == 1
        'first_answer_to_question'
      else
        'answer_to_question'
      end
    else
      "vote_#{up_or_down_vote}_#{@record.votable_type}".underscore
    end
  end

  def user
    @record.is_a?(Vote) ? @record.votable.user : @record.user
  end

  def up_or_down_vote
    @record.value > 0 ? 'up' : 'down'
  end

end