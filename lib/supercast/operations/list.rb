# frozen_string_literal: true

module Supercast
  module Operations
    module List
      # Lists an API resource
      #
      # ==== Attributes
      #
      # * +filters+ - A hash of filters to pass to the API
      # * +opts+ - A Hash of additional options (separate from the params /
      #   object values) to be added to the request.
      def list(filters = {}, opts = {})
        opts = Util.normalize_opts(opts)

        resp, opts = request(:get, resource_url, filters, opts)
        obj = DataList.construct_from({ data: resp.data }, opts)

        # set filters so that we can fetch the same limit, expansions, and
        # predicates when accessing the next and previous pages
        #
        # just for general cleanliness, remove any paging options
        obj.filters = filters.dup
        obj.filters.delete(:ending_before)
        obj.filters.delete(:starting_after)

        obj
      end
    end
  end
end
