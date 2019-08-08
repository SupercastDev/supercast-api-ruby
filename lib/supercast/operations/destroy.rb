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
          request(:delete, "#{resource_url}/#{id}", params, opts)
          true
        end
      end

      # Deletes an API resource instance
      #
      # Deletes the instance resource with the passed in parameters.
      #
      # ==== Attributes
      #
      # * +params+ - A hash of parameters to pass to the API
      # * +opts+ - A Hash of additional options (separate from the params /
      #   object values) to be added to the request.
      def destroy(params = {}, opts = {})
        request(:delete, resource_url, params, opts)
        true
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
