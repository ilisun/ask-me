class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_user, only: [:show, :edit, :update]

  respond_to :html
  authorize_resource

  def index
    respond_with(@users = User.all)
  end

  def show
    respond_with @user
  end

  def edit
    respond_with @user
  end

  def update
    sign_in @user, :bypass => true if @user.update(user_params)
    respond_with(@user)
  end

  private

  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :about, :avatar, :remove_avatar, :avatar_cache, :password, :password_confirmation)
  end

end
