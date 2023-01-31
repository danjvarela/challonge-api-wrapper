class V1::TournamentsController < ApplicationController
  def index
    response = Challonge::Tournament.all(index_params)
    render json: response.body, status: response.status
  end

  def create
    response = Challonge::Tournament.create({tournament: create_params})
    render json: response.body, status: response.status
  end

  def show
    response = Challonge::Tournament.show(params[:id], show_params)
    render json: response.body, status: response.status
  end

  private

  def index_params
    params.permit(:state, :type, :created_after, :created_before, :subdomain)
  end

  def create_params
    params.require(:tournament).permit(:name, :tournament_type, :url, :subdomain, :description, :open_signup, :hold_third_place_match, :pts_for_match_win, :pts_for_match_tie, :pts_for_game_win, :pts_for_game_tie, :pts_for_bye, :swiss_rounds, :ranked_by, :rr_pts_for_match_win, :rr_pts_for_match_tie, :rr_pts_for_game_win, :rr_pts_for_game_tie, :accept_attachments, :hide_forum, :show_rounds, :private, :notify_users_when_matches_open, :notify_users_when_the_tournament_ends, :sequential_pairings, :signup_cap, :start_at, :check_in_duration, :grand_finals_modifier)
  end

  def show_params
    params.permit(:include_participants, :include_participants)
  end
end
