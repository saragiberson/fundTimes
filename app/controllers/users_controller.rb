class UsersController < ApplicationController
  skip_before_action :venmo?, only: [:venmo]
  def venmo
  end

  def show
  end
end
