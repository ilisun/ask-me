require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  sign_in_user
  let(:question) { create(:question, user_id: @user.id) }
  let(:answer) { create(:answer, question: question, user_id: @user.id) }
  let(:another_answer) { create(:answer, question: question) }


  describe 'POST #create' do

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :json }.to change(question.answers, :count).by(1)
      end

      it 'render json response' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :json
        expect(response.status).to eq 201
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :json }.to_not change(Answer, :count)
      end

      it 'render json response' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :json
        expect(response.status).to eq 422
      end
    end

  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :json
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, id: answer, question_id: question, answer: { body: 'new body new body new body' }, format: :json
        answer.reload
        expect(answer.body).to eq 'new body new body new body'
      end

      it 'render update template' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :json
        expect(response.status).to eq 200
      end
    end

    context 'with invalid attributes' do
      before { patch :update, id: answer, answer: {body: nil}, question_id: question, format: :json }

      it 'does not changes answer attributes' do
        answer.reload
        expect(answer.body).to eq 'MyText MyText'
      end

      it 'render update template' do
        expect(response.status).to eq 422
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when he is author of answer' do
      before { answer }

      it 'deletes question' do
        expect { delete :destroy, id: answer, question_id: question, format: :json }.to change(Answer, :count).by(-1)
      end

      it 'render deletes template' do
        delete :destroy, id: answer, question_id: question, format: :json
        expect(response.status).to eq 200
      end
    end

    context 'when he is not author of answer' do
      before { another_answer }

      it 'deletes question' do
        expect { delete :destroy, id: another_answer, question_id: question, format: :json }.to change(Answer, :count).by(0)
      end

      it 'render deletes template' do
        delete :destroy, id: another_answer, question_id: question, format: :json
        expect(response.status).to eq 302
      end
    end
  end

  describe 'POST #accepted, #unaccepted' do
    before do
      answer
      post :accepted, id: answer
      answer.reload
    end

    it 'accepted answer' do
      expect(answer.accepted).to eq true
    end

    it 'unaccepted answer' do
      post :unaccepted, id: answer
      answer.reload
      expect(answer.accepted).to eq false
    end
  end

end
