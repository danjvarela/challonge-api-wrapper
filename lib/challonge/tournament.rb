require_relative "connection"

module Challonge
  module Tournament
    extend Challonge::Connection

    class << self
      def all(params = {})
        get("/v1/tournaments", params)
      end

      def create(params = {})
        post("/v1/tournaments") do |req|
          params.deep_symbolize_keys!
          tournament = params[:tournament]
          next if tournament.blank?
          tournament.keys.each do |key|
            req.params["tournament[#{key}]"] = tournament[key]
          end
        end
      end

      def show(id_or_url, params = {})
        get("/v1/tournaments/#{id_or_url}", params)
      end

      private :get, :post
    end
  end
end
