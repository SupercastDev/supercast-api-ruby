# frozen_string_literal: true

module Supercast
  module Operations
    module Find
      # Creates an API resource.
      #
      # ==== Attributes
      #
      # * +params+ - A hash of parameters to pass to the API
      # * +opts+ - A Hash of additional options (separate from the params /
      #   object values) to be added to the request.
      def find(id, opts = {})
        resp, opts = request(:get, "#{resource_url}/#{id}", opts)
        Util.convert_to_supercast_object(resp.data, opts)
      end
    end
  end
end
