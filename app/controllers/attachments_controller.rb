class AttachmentsController < ApplicationController
  before_action :load_attachment, only: [:destroy]


  def destroy
    @attachment.destroy
    flash[:notice] = 'Your attachment is successfully deleted.'
    # redirect_to :back
  end

  private

  def load_attachment
    @attachment = Attachment.find(params[:id])
  end

end
