class Event < ActiveRecord::Base
  has_many :user_events
  has_many :users, through: :user_events

  def admin
    User.find(self.admin_id)
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

  def current_rate_of_attendance
    attendance_rate = (self.users.count) / self.max_users.to_f
    attendance_rate = attendance_rate.round(2)
    attendance_rate*100
  end

  ## if max_users has been satisfied, we need to disable to the button to join.

  def charge_the_user
    reciever_email      = admin.email
    amount              = 0.02  #self.price_per_person
    note                = "I just paid #{self.admin.name} for #{self.name}! Payment made via Fundtimes."
    payer_access_token  = User.venmo_encrypted_token

    conn = Faraday.new(:url => 'https://api.venmo.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.post '/payments', { email: reciever_email, amount: amount, note: note, access_token: payer_access_token}
  end

  def make_total_payment
    users = []
    total_cost = self.total_price - self.price_per_person
      while total_commitment = total_ && self.paid == false
        for user != self.admin 
          charge_the_user
        end
      end
      self.paid = true
  end
end

 # def self.test(payer, reciever)
  #   reciever_email = reciever.email
  #   amount        = 0.02
  #   note          = "Paid"
  #   payer_access_token  = payer.venmo_encrypted_token

  #   conn = Faraday.new(:url => 'https://api.venmo.com') do |faraday|
  #     faraday.request  :url_encoded             # form-encode POST params
  #     faraday.response :logger                  # log requests to STDOUT
  #     faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  #   end
  #   response = conn.post '/payments', { email: reciever_email, amount: amount, note: note, access_token: payer_access_token}
  # end