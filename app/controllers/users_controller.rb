class UsersController < ApplicationController
  def index
    @users = User.order("id DESC").page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render "new"
    end
  end

  def update
    @user = User.find params[:id]
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
    @user = User.find params[:id]
    @user.destroy
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :email, :access_level)
    end
end
