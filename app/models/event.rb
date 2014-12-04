class Event < ActiveRecord::Base
  has_many :user_events
  has_many :users, through: :user_events

  # def admin
  #   User.find(self.admin_id)
  # end

  # def charge_the_user
  #   user_venmo_id = User.venmo_id
  #   amount        = self.price_per_person
  #   note          = "I just paid #{self.admin.name} for #{self.name}! Payment made via Fundtimes."
  #   access_token  = User.venmo_encrypted_token

  #   conn = Faraday.new(:url => 'https://api.venmo.com') do |faraday|
  #     faraday.request  :url_encoded             # form-encode POST params
  #     faraday.response :logger                  # log requests to STDOUT
  #     faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  #   end
  #   response = conn.post '/v1/payments', { user_id: user_venmo_id, amount: amount, note: note, access_token: access_token}
  # end

  def self.test(user, admin)
    user_venmo_id = user.venmo_id
    amount        = 0.01
    note          = "Paid"
    access_token  = user.venmo_encrypted_token

    conn = Faraday.new(:url => 'https://api.venmo.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    response = conn.post '/payments', { user_id: user_venmo_id, amount: amount, note: note, access_token: access_token}
  end

  def price_per_person 
    dollars_with_remainder = self.total_price/self.max_users.to_f
    dollars_and_cents = dollars_with_remainder.round(2)
    dollars_and_cents
  end

  def total_guests
    # does not include admin of event 
    self.users.find_all {|user| user.id != self.admin_id} 
  end
 
  ## if max_users has been satisfied, we need to disable to the button to join.

#   def make_total_payment
#     users = []
#     total_cost = self.total_price - self.price_per_person
#       while total_commitment = total_ && self.paid == false
#         for user != self.admin 
#           charge_the_user
#         end
#       end
#       self.paid = true
#   end
end


 # curl -X POST "https://api.venmo.com/v1/payment?user_id=#{seema.user_venmo_id}?amount=0.01?note=paid?access_token=#{sara.venmo_encrypted_token}"
