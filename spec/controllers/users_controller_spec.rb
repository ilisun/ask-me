require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let!(:user) { create(:user) }
  sign_in_current_user

  describe 'GET #index' do
    let(:users) { create_list(:user, 2) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:users)).to match_array(users << user)
    end
    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, id: user }

    it 'assings the requested user to @user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'PATCH #update' do

    context 'valid attributes' do
      it 'assings the requested user to @user' do
        patch :update, id: user, user: attributes_for(:user)
        expect(assigns(:user)).to eq user
      end

      it 'changes user attributes' do
        patch :update, id: user, user: { name: 'New Name', email: 'new_email@mail.ru'}
        user.reload
        expect(user.name).to eq 'New Name'
        expect(user.email).to eq 'new_email@mail.ru'
      end

      it 'redirects to the updated user' do
        patch :update, id: user, user: attributes_for(:user)
        expect(response).to redirect_to user
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: user, user: { email: nil} }

      it 'does not change user attributes' do
        old_email = user.email
        user.reload
        expect(user.email).to eq old_email
      end

      it 're-renders edit view' do
        expect(response).to render_template :'edit'
      end
    end
  end

end
