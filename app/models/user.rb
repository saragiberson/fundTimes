class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  def self.create_twitter_with_omniauth(auth)
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