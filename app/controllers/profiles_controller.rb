class ProfilesController < ApplicationController
  def edit
  end

  def update
    if current_user.update(profile_params)
      flash[:notice] = t ".notice"
    else
      flash[:alert] = t ".alert"
    end

    render :edit
  end

  private

  def profile_params
    params.require(:profile).permit(:email,
                                    :password,
                                    :password_confirmation,
                                    :locale)
  end
end
