require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  sign_in_user
  let(:question) { create(:question, user_id: @user.id) }
  let(:answer) { create(:answer, question: question, user_id: @user.id) }
  let(:another_answer) { create(:answer, question: question) }


  describe 'POST #create' do

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, answer: attributes_for(:answer), question_id: question, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js }.to_not change(Answer, :count)
      end

      it 'render crate template' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question, format: :js
        expect(response).to render_template "answers/create"
      end
    end

  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:answer)).to eq answer
      end

      it 'assigns the requested question to @question' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(assigns(:question)).to eq question
      end

      it 'changes answer attributes' do
        patch :update, id: answer, question_id: question, answer: { body: 'new body new body new body' }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body new body new body'
      end

      it 'render update template' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response.status).to eq 200
      end
    end

    context 'with invalid attributes' do
      before { patch :update, id: answer, answer: {body: nil}, question_id: question, format: :js }

      it 'does not changes answer attributes' do
        answer.reload
        expect(answer.body).to eq 'MyText MyText'
      end

      it 'render update template' do
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when he is author of answer' do
      before { answer }

      it 'deletes question' do
        expect { delete :destroy, id: answer, question_id: question }.to change(Answer, :count).by(-1)
      end

      it 'redirect to index view' do
        delete :destroy, id: answer, question_id: question
        expect(response).to redirect_to answer.question
      end
    end

    context 'when he is not author of answer' do
      before { another_answer }

      it 'deletes question' do
        expect { delete :destroy, id: another_answer, question_id: question }.to change(Answer, :count).by(0)
      end

      it 'redirect to index view' do
        delete :destroy, id: another_answer, question_id: question
        expect(response).to redirect_to questions_path
      end
    end
  end

end
