module Challonge
  module Queries
    module Helpers
      # Infers path name based on the module name
      # Optionally takes an id which gets appended at the end of the path
      def path(id = nil)
        pathname = name.split("::").last.pluralize.downcase
        suffix = "/#{id}" unless id.blank?
        "/v1/#{pathname}#{suffix}"
      end
    end
  end
end
