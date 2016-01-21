class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_action :load_omniauth_info, only: [:facebook, :vkontakte]
  before_action :load_user_and_oauth, only: [:facebook, :vkontakte]

  def facebook
  end

  def vkontakte
  end

  private

  def load_omniauth_info
    @auth = request.env['omniauth.auth']
  end

  def load_user_and_oauth
    @user = User.find_for_oauth(@auth)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{@auth.provider.capitalize}") if is_navigational_format?
    end
  end

end