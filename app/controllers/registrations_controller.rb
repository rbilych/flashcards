class RegistrationsController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)

    if @user.save
      login(registration_params[:email], registration_params[:password])
      flash[:notice] = "Welcome!"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end
