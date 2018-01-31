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

    matches.each do |match|
      user1 = User.where(id: match.studenta_id)
      user2 = User.where(id: match.studentb_id)
    end

    if matches.empty?
      render status: 422, json: {
        message: "Matches could not be created",
        errors: match.errors
      }.to_json
    else
      render status: 201, json: {
        message: "Matches succesfully created",
        matches: matches,
      }.to_json
    end
  end
  private

end
