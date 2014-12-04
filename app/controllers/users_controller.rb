class UsersController < ApplicationController
    skip_before_filter :venmo?, only: [:venmo]
  def venmo
  end

  def show
  end
end
