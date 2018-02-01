class Api::UsersController < ApplicationController
  def index
    render status: 200, json: {
      users: User.all
    }.to_json
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
    user.save

    render status: 200,  json:{status:user.status, id:user.id, notice:"status changed"}
  end
  private
  def get_user
    User.find(params[:id])
  end
end
