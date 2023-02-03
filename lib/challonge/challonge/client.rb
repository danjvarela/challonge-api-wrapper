require_relative "constants"
require_relative "middlewares/response/resourcify"

module Challonge
  class Client < Faraday::Connection
    def initialize(options = {})
      options[:params] = {api_key: TOKEN}
      options[:headers] = {"Accept" => "application/json"}

      super(BASE_URL, options) do |conn|
        conn.use Middlewares::Response::Resourcify
        conn.response :json
        conn.request :json
      end
    end
  end
end
