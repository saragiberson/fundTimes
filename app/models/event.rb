class Event < ActiveRecord::Base
  has_many :user_events
  has_many :users, through: :user_events

  def admin
    User.find(self.admin_id)
  end

  def price_per_person    
    price_per_person = self.total_price/self.max_users.to_f
    price_per_person = price_per_person/100.0

  end

  def total_guests
    # does not include admin of event 
    self.users.find_all {|user| user.id != self.admin_id} 
  end
 
  ## if max_users has been satisfied, we need to disable to the button to join.
end
