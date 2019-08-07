# frozen_string_literal: true

module Supercast
  module Operations
    module Destroy
      module ClassMethods
        # Deletes an API resource
        #
        # Deletes the identified resource with the passed in parameters.
        #
        # ==== Attributes
        #
        # * +id+ - ID of the resource to delete.
        # * +params+ - A hash of parameters to pass to the API
        # * +opts+ - A Hash of additional options (separate from the params /
        #   object values) to be added to the request.
        def destroy(id, params = {}, opts = {})
          resp, opts = request(:delete, "#{resource_url}/#{id}", params, opts)
          Util.convert_to_stripe_object(resp.data, opts)
        end
      end

      def destroy(params = {}, opts = {})
        resp, opts = request(:delete, resource_url, params, opts)
        initialize_from(resp.data, opts)
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
