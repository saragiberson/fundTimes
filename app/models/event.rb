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

  def charge_the_user(user)
    reciever_email      = self.admin.email
    amount              = 0.02  #self.price_per_person
    note                = "I just paid #{self.admin.name} for #{self.name}! Payment made via Fundtimes."
    payer_access_token  = user.venmo_encrypted_token

    conn = Faraday.new(:url => 'https://api.venmo.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
    response = conn.post '/payments', { email: reciever_email, amount: amount, note: note, access_token: payer_access_token}
  end

  def charge_all_users
    self.users.each do |user|
      if user != self.admin
        charge_the_user(user)
      end
    end
    self.paid = true
    self.save
  end

  def full?
    self.users.count == self.max_users
  end

  def make_payment
    if full?
      charge_all_users
    end
  end

  def current_rate_of_attendance
   attendance_rate = (self.users.count) / self.max_users.to_f
   attendance_rate = attendance_rate.round(2)
   attendance_rate*100
 end

end

 