require_relative "../../error"
require_relative "../../resource"

module Challonge
  module Middlewares
    module Response
      # Converts response body to a Resource object
      # Response body should be either a Hash or an Array
      # Important to run this after the json middleware
      class Resourcify < Faraday::Middleware
        def on_complete(env)
          body = env.body

          if env.status.to_s.match?(/^2\d{2}$/)
            resource_names = ["tournament", "match", "participant"]

            case body
            when Array
              resource_name = resource_names.detect { |name| body.first.key? name }
              env.body.map! { |element| Resource.new element[resource_name] }
            when Hash
              resource_name = resource_names.detect { |name| body.key? name }
              env.body = Resource.new body[resource_name]
            else
              raise Error, "Response body must be a Hash or Array"
            end
          else
            env.body = Resource.new body
          end
        end
      end
    end
  end
end
