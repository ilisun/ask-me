require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  sign_in_user
  let(:question) { create(:question, user_id: @user.id) }
  let(:answer) { create(:answer, question: question, user_id: @user.id) }
  let(:another_answer) { create(:answer, question: question) }


  describe 'POST #create' do

    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, answer: attributes_for(:answer), question_id: question}.to change(question.answers, :count).by(1)
      end

      it 'render create template' do
        post :create, answer: attributes_for(:answer), question_id: question
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, answer: attributes_for(:invalid_answer), question_id: question}.to_not change(Answer, :count)
      end

      it 'render crate template' do
        post :create, answer: attributes_for(:invalid_answer), question_id: question
        expect(response).to render_template "questions/show"
      end
    end

  end

  describe 'GET #edit' do

    context 'when he is author of answer' do
      before { get :edit, id: answer, question_id: question }

      it 'assings the requested answer to @answer' do
        expect(assigns(:answer)).to eq answer
      end

      it 'renders edit view' do
        expect(response).to render_template :edit
      end
    end

    context 'when he is not author of answer' do
      before { get :edit, id: another_answer, question_id: question }

      it 'assings the requested answer to @answer' do
        expect(assigns(:another_answer)).to_not eq another_answer
      end
      it 'renders edit view' do
        expect(response).to redirect_to questions_path
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end

      it 'assigns the requested question to @question' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer)
        expect(assigns(:question)).to eq question
      end

      it 'changes answer attributes' do
        patch :update, id: answer, question_id: question, answer: { body: 'new body new body new body' }
        answer.reload
        expect(answer.body).to eq 'new body new body new body'
      end

      it 'render update template' do
        patch :update, id: answer, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      before { patch :update, id: answer, answer: {body: nil}, question_id: question }

      it 'does not changes answer attributes' do
        answer.reload
        expect(answer.body).to eq 'MyText MyText'
      end

      it 'render update template' do
        expect(response).to render_template :edit
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
