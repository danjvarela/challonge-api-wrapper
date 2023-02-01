require_relative "../../error"
require_relative "../../mash"

module Challonge
  module Middlewares
    module Response
      # converts responses to Hashie::Mash objects
      class Mashify < Faraday::Middleware
        def on_complete(env)
          body = env.body
          case body
          when Array
            env.body.map! { |element| Challonge::Mash.new(element) }
          when Hash
            env.body = Challonge::Mash.new(body)
          else
            raise Challonge::Error, "Response body should be an instance of Nil, Array, or Hash class"
          end
        end
      end
    end
  end
end
