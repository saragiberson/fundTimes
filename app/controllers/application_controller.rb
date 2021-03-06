class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :require_login, :venmo?, except: [:home]

  def home  
  end
 
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user != nil ? true : false
  end

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end

  def venmo?
    unless current_user.venmo_encrypted_token
      redirect_to venmo_path
    end
  end
end
