class UsersController < ApplicationController
  before_action :require_login, only: :update

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(params[:user][:email], params[:user][:password])
      flash[:notice] = "Welcome!"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "Updated"
    else
      flash[:alert] = "Not updated"
    end

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
