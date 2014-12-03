class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  def self.create_or_update(auth)
      if auth[:provider] == "twitter"
        @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_twitter_with_omniauth(auth)
        session[:user_id] = user.id
      elsif auth[:provider] == "venmo"
        binding.pry
        current_user.update_user_with_venmo(auth)
      end
  end

  private

  def create_twitter_with_omniauth(auth)
   create! do |user|
      user.uid               = auth["uid"]
      user.name              = auth["info"]["name"]
      user.twitter_handle    = auth["info"]["nickname"]
      user.twitter_image_url = auth["info"]["image"]
    end
  end

  def update_user_with_venmo(auth)
    self.venmo_id              = auth["uid"]
    self.venmo_encrypted_token = auth["credentials"]["token"]
    self.save
  end

end