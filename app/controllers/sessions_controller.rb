class SessionsController < ApplicationController
  skip_before_filter :require_login, only: [:create, :destroy]
  skip_before_filter :venmo?, only: [:create, :destroy]
  
  def create
    if auth[:provider] == "twitter"
      @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_twitter_with_omniauth(auth)
      session[:user_id] = @user.id
    elsif auth[:provider] == "venmo"
      current_user.update_user_with_venmo(auth)
    end
    redirect_to user_path(current_user)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

protected

  def auth
    request.env["omniauth.auth"]
  end
end


