class Reputation < ActiveRecord::Base
  belongs_to :user
  belongs_to :reputationable, polymorphic: true

  VALUES = {
      answer_to_question:             1,
      vote_up_question:               2,
      vote_up_answer:                 1,
      vote_down_question:            -2,
      vote_down_answer:              -1,
      accepted_answer:                3,
      first_answer_to_question:       1,
      first_answer_to_your_question:  3,
      answer_to_your_question:        2,
  }

  def increase
    if score
      update!(value: score)
      user.increment!(:reputation, score)
    end
  end

  private

  def score
    VALUES[operation.to_sym]
  end

end
