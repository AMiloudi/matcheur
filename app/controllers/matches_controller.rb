class MatchesController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.status = "admin"
      @matches = Match.where(day:Time.now.strftime("%Y-%m-%d"))
      render :_indexadmin
    elsif current_user.status = "student"
      @matches = current_user.matches.all
      render :_indexstudent
    else
      root_path
    end
  end
end
