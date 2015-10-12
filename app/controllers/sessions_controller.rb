class SessionsController < ApplicationController
  def new
  end

  def create
    if login(session_params[:email],
             session_params[:password],
             session_params[:remember_me])

      flash[:notice] = 'Welcome back!'
      redirect_back_or_to root_path
    else
      flash[:alert] = 'Email and/or password id incorrect'
      render :new
    end
  end

  def destroy
    logout

    flash[:notice] = 'See you!'
    redirect_to log_in_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end
end
