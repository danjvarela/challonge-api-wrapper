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
          req.params = params
        end
      end

      private :get, :post
    end
  end
end
