class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login, :set_client
 
  private

    def require_login
      unless logged_in?
        redirect_to new_login_path # halts request cycle
      end
    end

    def logged_in?
      !!current_user
    end
  
    def log_in(user)
      session[:user_id] = user.id
    end

    def log_out
      session.delete(:user_id)
      session.delete(:token)
      session.delete(:secret)
      @current_user = nil
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def set_client
      if logged_in?
        @client = create_client
      end
    end

    def create_client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_KEY']
        config.consumer_secret     = ENV['TWITTER_SECRET']
        config.access_token        = session[:token]
        config.access_token_secret = session[:secret]
      end
    end
    helper_method :current_user
end
