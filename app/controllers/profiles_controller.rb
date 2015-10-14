class ProfilesController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(profile_params)
      flash[:notice] = "Updated"
    else
      flash[:alert] = "Not updated"
    end

    render :edit
  end

  private

  def profile_params
    params.require(:profile).permit(:email, :password, :password_confirmation)
  end
end
