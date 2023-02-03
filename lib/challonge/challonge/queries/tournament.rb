require_relative "helpers"
require_relative "../client"
require_relative "../resource"

module Challonge
  module Tournament
    class << self
      include Queries::Helpers

      @@client = Client.new

      def create(params = {})
        converted_params = Resource.new params
        body = converted_params.key?(:tournament) ? converted_params : {tournament: converted_params}
        @@client.post(path, body)
      end

      def all(params = {})
        @@client.get(path, params)
      end

      def find(id, params = {})
        @@client.get(path(id), params)
      end

      def destroy(id = nil)
        @@client.delete(path(id))
      end

      def update(id = nil, params = {})
        converted_params = Resource.new params
        body = converted_params.key?(:tournament) ? converted_params : {tournament: converted_params}
        @@client.put(path(id), body)
      end

      private :path
    end
  end
end
