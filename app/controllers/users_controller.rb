class UsersController < ApplicationController
<<<<<<< HEAD
  skip_before_action :venmo?, only: [:show, :venmo]
=======
  skip_before_action :venmo?, only: [:venmo, :show]
>>>>>>> 635863d65e02b641725f93bb8c54d0702a753890
  def venmo
  end

  def show
  end
end
