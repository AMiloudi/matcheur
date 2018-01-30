class MatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.status == "admin"
      @matches = Match.all
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
      @matches = Match.where(day:Date.today)
      render :_showadmin
    elsif current_user.status == "student"
      matches = get_student_matches(current_user)
      @match = matches.find_by(day:Date.today)
      render :_showstudent
    else
      new_user_session
    end
  end

  def new
    if current_user.status == "admin"
      @match = Match.new
    else
      render :root
    end
  end
  def create
    Match.generate_matches(params[:match][:day].to_date)

  end

  private

  def get_student_matches(user)
    Match.where(studenta:user).or(Match.where(studentb:user))
  end

end
