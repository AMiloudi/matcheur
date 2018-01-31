class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    @users = User.all
    if current_user.status == "student"
      render :root
    end
  end

  def show

  end
  def update
    user = get_user
    if user.status == "admin"
      user.status = "student"
    else
      user.status = "admin"
    end
    render status: 200,  json:{status:user.status, id:user.id, notice:"status changed"}

  end

  private
  def user_params
    params.require(:user).permit(:id)
  end

  def get_user
    User.find(user_params)
  end
end
