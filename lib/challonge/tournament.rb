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
          next if params[:tournament].blank?
          params[:tournament].keys.each do |key|
            req.params["tournament[#{key}]"] = params[:tournament][key]
          end
        end
      end

      private :get, :post
    end
  end
end
