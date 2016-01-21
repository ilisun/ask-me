class Api::V1::ProfilesController < Api::V1::BaseController

  def me
    authorize! :read, current_resource_owner
    respond_with current_resource_owner
  end

end