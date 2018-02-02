class Api::MatchesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render status: 200, json: {
      matches: Match.all
    }.to_json
  end

  def create
    Match.generate_matches(params[:day].to_date)
    matches = Match.where(day:params[:day])
    if matches.empty?
      render status: 422, json: {
        message: "Matches could not be created",
        errors: match.errors
      }.to_json
    else
      students = User.where(status:"student")
      render status: 201, json: {
        message: "Matches succesfully created",
        matches: matches,
        students: students,
      }.to_json
    end
  end
  private

end
