class AttachmentsController < ApplicationController
  before_action :load_attachment, only: [:destroy]

  respond_to :json
  authorize_resource


  def destroy
    @attachment.destroy
    respond_with(@attachment, json: @attachment)
  end

  private

  def load_attachment
    @attachment = Attachment.find(params[:id])
  end

end
