require 'rails_helper'

RSpec.describe AttachmentsController, :type => :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user)}
  # let(:answer) { create(:answer, user: user)}
  let!(:attachment) { create(:attachment, attachmentable: question) }
  # let!(:attachment_answer) { create(:attachment, attachmentable: answer) }
  # let!(:another_attachment) {create(:attachment, attachmentable: create(:question))}
  # let!(:another_attachment_answer) {create(:attachment, attachmentable: create(:answer))}

  sign_in_user

  describe 'DELETE #destroy' do
    before { question }

    it 'deletes attachment from db' do
      expect { delete :destroy, id: attachment, format: :js }.to change(Attachment, :count).by(-1)
    end

    it 'render to destroy template' do
      delete :destroy, id: attachment, format: :js
      expect(response).to render_template :destroy
    end

  end
end