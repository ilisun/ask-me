require 'rails_helper'

RSpec.describe AttachmentsController, :type => :controller do

  sign_in_user
  let(:question) { create(:question, user_id: @user.id)}
  let!(:attachment) { create(:attachment, attachmentable: question) }


  describe 'DELETE #destroy' do
    before { question }

    it 'deletes attachment from db' do
      expect { delete :destroy, id: attachment, format: :json }.to change(Attachment, :count).by(-1)
    end

    it 'render to destroy template' do
      delete :destroy, id: attachment, format: :json
      expect(response.status).to eq 200
    end

  end
end