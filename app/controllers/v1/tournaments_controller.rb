class V1::TournamentsController < ApplicationController
  def render_json(response)
    render json: response.body, status: response.status
  end

  def index
    response = Challonge::Tournament.all(params)
    render_json(response)
  end

  def create
    response = Challonge::Tournament.create(params)
    render_json(response)
  end

  def update
    response = Challonge::Tournament.update(params[:id], params)
    render_json(response)
  end

  def show
    response = Challonge::Tournament.find(params[:id], params)
    render_json(response)
  end

  def destroy
    response = Challonge::Tournament.destroy(params[:id])
    render_json(response)
  end
end
