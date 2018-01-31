class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    @users = User.all
    if current_user.status == "student"
      render :root
    end
  end

end
