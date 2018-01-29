class MatchesController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user.status == "admin"
      render :_indexadmin
    elsif current_user.status == "student"
      @matches = get_student_matches(current_user)
      render :_indexstudent
    else
      new_user_session
    end
  end
  def show
    if current_user.status == "admin"
      @matches = Match.where(day:Time.now.strftime("%Y-%m-%d"))
      render :_showadmin
    elsif current_user.status == "student"
      @match = current_user.matches.find_by(day:Time.now.strftime("%Y-%m-%d"))
      render :_showstudent
    else
      new_user_session
    end
  end
  def create
    Matches.generate_matches
  end
  private
  def get_student_matches(user)
    Match.where(studenta:user).or(Match.where(studentb:user))
  end
end
