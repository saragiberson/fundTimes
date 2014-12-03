class SessionsController < ApplicationController
  def create
    User.create_or_update(auth, current_user)
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

protected

  def auth
    request.env["omniauth.auth"]
  end
end