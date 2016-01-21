require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  sign_in_user
  let!(:question) { create(:question, user_id: @user.id) }
  let!(:answer) { create(:answer, question: question, user_id: @user.id) }
  let(:comment_question) {create(:comment, commentable: question, user_id: @user.id)}
  let(:comment_answer) {create(:comment, commentable: answer, user_id: @user.id)}

  describe 'POST #create' do
    it 'loads question if parent is question' do
      post :create, comment: attributes_for(:comment), question_id: question, format: :json
      expect(assigns(:parent)).to eq question
    end

    it 'loads question if parent is answer' do
      post :create, comment: attributes_for(:comment), answer_id: answer, format: :json
      expect(assigns(:parent)).to eq answer
    end

  end

  describe 'GET #new' do
    context "for comment of question" do
      before {get :new, question_id: question, format: :json}

      context "when user is logged in" do
        it 'assigns new Comment to @comment' do
          expect(assigns(:comment)).to be_a_new(Comment)
        end

        it 'render new view' do
          expect(response.status).to eq 200
        end
      end
    end

    context "for comment of answer" do
      before {get :new, answer_id: answer, format: :json}

      context "when user is logged in" do
        it 'assigns new Comment to @comment' do
          expect(assigns(:comment)).to be_a_new(Comment)
        end

        it 'render new view' do
          expect(response.status).to eq 200
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before {
      comment_question
      comment_answer
    }

    it 'delete comment of question' do
      expect { delete :destroy, id: comment_question, format: :json }.to change(Comment, :count).by(-1)
      expect(response.status).to eq 200
    end

    it 'delete comment of answer' do
      expect { delete :destroy, id: comment_answer, format: :json }.to change(Comment, :count).by(-1)
      expect(response.status).to eq 200
    end

  end


end
