# frozen_string_literal: true

module Supercast
  module Operations
    module Feeds
      module ClassMethods
        # Enables the feeds of the identified resource with the passed in parameters.
        #
        # ==== Attributes
        #
        # * +id+ - ID of the resource to activate the feeds for.
        # * +opts+ - A Hash of additional options to be added to the request.
        def activate(id, opts = {})
          params = { feed_token: { state: 'active' } }
          request(:patch, "#{resource_url}/#{id}", params, opts)
          true
        end

        # Suspends the feeds of the identified resource with the passed in parameters.
        #
        # ==== Attributes
        #
        # * +id+ - ID of the resource to suspend the feeds for.
        # * +opts+ - A Hash of additional options to be added to the request.
        def suspend(id, opts = {})
          params = { feed_token: { state: 'suspended' } }
          request(:patch, "#{resource_url}/#{id}", params, opts)
          true
        end

        # Deactivate the feeds of the identified resource with the passed in parameters.
        #
        # ==== Attributes
        #
        # * +id+ - ID of the resource to deactivate the feeds for.
        # * +opts+ - A Hash of additional options to be added to the request.
        def deactivate(id, opts = {})
          params = { feed_token: { state: 'inactive' } }
          request(:patch, "#{resource_url}/#{id}", params, opts)
          true
        end
      end

      # Enables the feeds of the current resource.
      #
      # ==== Attributes
      #
      # * +opts+ - A Hash of additional options to be added to the request.
      def activate(opts = {})
        params = { feed_token: { state: 'active' } }
        request(:patch, resource_url, params, opts)
        true
      end

      # Suspends the feeds of the current resource.
      #
      # ==== Attributes
      #
      # * +opts+ - A Hash of additional options to be added to the request.
      def suspend(opts = {})
        params = { feed_token: { state: 'suspended' } }
        request(:patch, resource_url, params, opts)
        true
      end

      # Deactivate the feeds of the current resource.
      #
      # ==== Attributes
      #
      # * +opts+ - A Hash of additional options to be added to the request.
      def deactivate(opts = {})
        params = { feed_token: { state: 'inactive' } }
        request(:patch, resource_url, params, opts)
        true
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
