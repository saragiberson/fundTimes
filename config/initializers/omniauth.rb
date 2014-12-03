 Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :venmo, ENV['VENMO_CLIENT_ID'], ENV['VENMO_SECRET']
 end