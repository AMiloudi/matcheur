matchclass Api::MatchesController < ApplicationController
 skip_before_action :verify_authenticity_token

 def index
   render status: 200, json: {
     matches: Match.all
   }.to_json
 end

 def create
      Match.generate_matches(params[:match][:day].to_date)

    if match.save
      render status: 201, json: {
        message: "Match successfully created",
        match: match
      }.to_json
    else
      render status: 422, json: {
        errors: match.errors
      }.to_json
    end
  end



  end

  private
