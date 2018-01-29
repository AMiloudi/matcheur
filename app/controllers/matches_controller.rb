class MatchesController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.status = "admin"
      @matches = Match.where(day:Time.now.strftime("%Y-%m-%d"))
      render :_indexadmin
    elsif current_user.status = "student"
      @matches = current_user.matches.where(day:Time.now.strftime("%Y-%m-%d"))
      render :_indexstudent
    else
      new_user_session
    end
  end
end
