class V1::TournamentsController < ApplicationController
  def index
    response = Challonge::Tournament.all(index_params)
    render json: response.body, status: response.status
  end

  def create
    response = Challonge::Tournament.create
    render json: response.body, status: response.status
  end

  private

  def index_params
    params.permit(:state, :type, :created_after, :created_before, :subdomain)
  end
end
