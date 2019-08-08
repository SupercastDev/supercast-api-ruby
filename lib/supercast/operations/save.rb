# frozen_string_literal: true

module Supercast
  module Operations
    module Save
      module ClassMethods
        # Updates an API resource
        #
        # Updates the identified resource with the passed in parameters.
        #
        # ==== Attributes
        #
        # * +id+ - ID of the resource to update.
        # * +params+ - A hash of parameters to pass to the API
        # * +opts+ - A Hash of additional options (separate from the params /
        #   object values) to be added to the request.
        def update(id, params = {}, opts = {})
          params.each_key do |k|
            raise ArgumentError, "Cannot update protected field: #{k}" if protected_fields.include?(k)
          end

          resp, opts = request(:patch, "#{resource_url}/#{id}", Hash[object_name => params], opts)
          Util.convert_to_supercast_object(resp.data, opts)
        end
      end

      # Creates or updates an API resource.
      #
      # If the resource doesn't yet have an assigned ID and the resource is one
      # that can be created, then the method attempts to create the resource.
      # The resource is updated otherwise.
      #
      # ==== Attributes
      #
      # * +params+ - Overrides any parameters in the resource's serialized data
      #   and includes them in the create or update. If +:req_url:+ is included
      #   in the list, it overrides the update URL used for the create or
      #   update.
      # * +opts+ - A Hash of additional options (separate from the params /
      #   object values) to be added to the request.
      def save(params = {}, opts = {})
        update_attributes(params)

        # Now remove any parameters that look like object attributes.
        params = params.reject { |k, _| respond_to?(k) }

        values = serialize_params(self).merge(params)

        # note that id gets removed here our call to #url above has already
        # generated a uri for this object with an identifier baked in
        values.delete(:id)

        resp, opts = request(save_verb, save_url, Hash[object_name => values], opts)
        initialize_from(resp.data, opts)
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      private

      def save_verb
        # This switch essentially allows us "upsert"-like functionality. If the
        # API resource doesn't have an ID set (suggesting that it's new) and
        # its class responds to .create (which comes from
        # Supercast::Operations::Create), then use the verb to create a new
        # resource, otherwise use the verb to update a resource.
        self[:id].nil? && self.class.respond_to?(:create) ? :post : :patch
      end

      def save_url
        # This switch essentially allows us "upsert"-like functionality. If the
        # API resource doesn't have an ID set (suggesting that it's new) and
        # its class responds to .create (which comes from
        # Supercast::Operations::Create), then use the URL to create a new
        # resource. Otherwise, generate a URL based on the object's identifier
        # for a normal update.
        if self[:id].nil? && self.class.respond_to?(:create)
          self.class.resource_url
        else
          resource_url
        end
      end
    end
  end
end
