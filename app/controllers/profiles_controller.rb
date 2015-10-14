class ProfilesController < ApplicationController
  def edit
  end

  def update
    if current_user.update(profile_params)
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
