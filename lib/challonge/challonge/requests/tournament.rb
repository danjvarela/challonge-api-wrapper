require_relative "../connection"

module Challonge
  module Tournament
    extend Challonge::Connection

    class << self
      def all(params = {})
        get(url_path, params)
      end

      def create(params = {})
        post(url_path) do |req|
          params.deep_symbolize_keys!
          tournament = params[:tournament]
          next if tournament.blank?
          tournament.keys.each do |key|
            req.params["tournament[#{key}]"] = tournament[key]
          end
        end
      end

      def show(id_or_url, params = {})
        get("#{url_path}/#{id_or_url}", params)
      end

      def destroy(id_or_url, params = {})
        delete("#{url_path}/#{id_or_url}", params)
      end

      private :get, :post, :delete

      private

      def url_path
        "/v1/tournaments"
      end
    end
  end
end
