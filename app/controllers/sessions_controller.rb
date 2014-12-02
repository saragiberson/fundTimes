class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  skip_before_action :set_client, only: [:create, :new, :destroy]

  def create
    @user = User.login_from_omniauth(auth_hash)
    log_in(@user)
    redirect_to '/'
  end

  def destroy
    log_out
    redirect_to root_url
  end

  protected

  def auth_hash
    info             = request.env['omniauth.auth']
    session[:token]  = info["credentials"]["token"]
    session[:secret] = info["credentials"]["secret"]
    info
  end
end
