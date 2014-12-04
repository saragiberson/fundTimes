class UsersController < ApplicationController
  skip_before_action :venmo?, only: [:venmo, :show]
  def venmo
  end

  def show
  end
end
