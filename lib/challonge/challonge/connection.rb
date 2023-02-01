require_relative "base_url"
require_relative "middlewares/response/mashify"

module Challonge
  module Connection
    @@connection = Faraday.new(
      url: Challonge::BASE_URL,
      headers: {
        "Accept" => "application/json"
      }
    ) do |conn|
      conn.use Challonge::Middlewares::Response::Mashify
      conn.response :json # decode res bodies as JSON
    end

    def get(url, params = {}, headers = nil)
      @@connection.get(url, params_with_token(params), headers) do |req|
        yield req if block_given?
      end
    end

    def post(url, body = nil, headers = nil)
      @@connection.post(url, body, headers) do |req|
        yield req if block_given?
        req.params["api_key"] = ENV["CHALLONGE_API_KEY"]
      end
    end

    def params_with_token(params)
      {api_key: ENV["CHALLONGE_API_KEY"]}.merge(params)
    end

    private :params_with_token
  end
end
