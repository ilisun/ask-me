require 'rails_helper'

RSpec.describe VotesController, type: :controller do

  sign_in_user
  let(:question) { create(:question, user_id: @user.id) }
  let!(:answer) { create(:answer, question: question, user_id: @user.id) }

  describe 'POST #vote_up' do
    it 'vote first, create record in Vote model' do
      expect { post :vote_up, id: answer, class: Answer }.to change(Vote, :count).by(1)
      expect(Vote.first.value).to eq 1
    end

    it 'update attribute votes_sum in parent model' do
      expect { post :vote_up, id: answer, class: Answer }.to change{answer.reload.votes_sum}.by(1)
    end

    it 'renders show view' do
      post :vote_up, id: answer, class: Answer
      expect(response.status).to eq 200
    end
  end

  describe 'POST #vote_down' do
    it 'vote first, create record in Vote model' do
      expect { post :vote_down, id: answer, class: Answer }.to change(Vote, :count).by(1)
      expect(Vote.first.value).to eq -1
    end

    it 'update attribute votes_sum in parent model' do
      expect { post :vote_down, id: answer, class: Answer }.to change{answer.reload.votes_sum}.by(-1)
    end

    it 'renders show view' do
      post :vote_down, id: answer, class: Answer
      expect(response.status).to eq 200
    end
  end

end
