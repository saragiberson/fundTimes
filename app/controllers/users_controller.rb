class UsersController < ApplicationController
  skip_before_action :venmo?, only: [:show]
  def venmo
  end

  def show
  end
end
