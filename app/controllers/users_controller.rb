class UsersController < ApplicationController
  skip_before_action :venmo?, only: [:show, :venmo]
  def venmo
  end

  def show
  end
end
