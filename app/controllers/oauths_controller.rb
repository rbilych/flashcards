class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path, notice: t(".notice", provider: provider.titleize)
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path, notice: t(".notice", provider: provider.titleize)
      rescue
        redirect_to root_path, alert: t(".alert", provider: provider.titleize)
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
