class Event < ActiveRecord::Base
  has_many :user_events
  has_many :users, through: :user_events

  def admin
    User.find(self.admin_id)
  end
end
