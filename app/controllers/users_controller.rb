class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.order("id DESC").page(params[:page]).per(10)
  end

  def create
    @user.attributes = user_params

    if @user.save
      redirect_to users_path
    else
      render "new"
    end
  end

  def update
    set_attributes = user_params.to_hash
    set_attributes.delete "password" if set_attributes["password"].nil? or set_attributes["password"].blank?
    @user.attributes = set_attributes

    if @user.save
      redirect_to users_path
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :email, :access_level)
    end
end
