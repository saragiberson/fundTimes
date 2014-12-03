require 'pry'
class User < ActiveRecord::Base
  has_many :user_events
  has_many :events, through: :user_events

  def self.create_with_omniauth(auth)
    if auth[:provider] == "twitter"
      binding.pry
      create! do |user|
        user.provider          = auth["provider"]
        user.uid               = auth["uid"]
        user.name              = auth["info"]["name"]
        user.twitter_handle    = auth["info"]["nickname"]
        user.twitter_image_url = auth["info"]["image"]
      end
    end
  end
end
