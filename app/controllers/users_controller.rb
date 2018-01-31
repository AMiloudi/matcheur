class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    @users = User.all
    if current_user.status == "student"
      redirect_to :root
    end
  end


  def update
    user = get_user
    if user.status == "admin"
      user.status = "student"
    else
      user.status = "admin"
    end
    user.save

    render status: 200,  json:{status:user.status, id:user.id, notice:"status changed"}
  end

  private

  def get_user
    User.find(params[:id])
  end
master
end
