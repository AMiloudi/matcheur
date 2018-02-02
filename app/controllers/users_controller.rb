class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    @users = User.all
    if current_user.status == "student"
      redirect_to :root
    end
  end
  private
  def get_user
    User.find(params[:id])
  end

end
