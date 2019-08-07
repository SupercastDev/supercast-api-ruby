# frozen_string_literal: true

module Supercast
  class Resource < SupercastObject
    include Supercast::APIOperations::Request

    def self.class_name
      name.split('::')[-1]
    end

    def self.resource_url
      if self == APIResource
        raise NotImplementedError,
              'APIResource is an abstract class. You should perform actions ' \
              'on its subclasses (Charge, Customer, etc.)'
      end

      # Namespaces are separated in object names with periods (.) and in URLs
      # with forward slashes (/), so replace the former with the latter.
      "/v1/#{self::OBJECT_NAME.downcase.tr('.', '/')}s"
    end

    # Adds a custom method to a resource class. This is used to add support for
    # non-CRUD API requests. custom_method takes the following parameters:
    # - name: the name of the custom method to create (as a symbol)
    # - http_verb: the HTTP verb for the API request (:get, :post, or :delete)
    # - http_path: the path to append to the resource's URL. If not provided,
    #              the name is used as the path
    #
    # For example, this call:
    #     custom_method :suspend, http_verb: post
    # adds a `suspend` class method to the resource class that, when called,
    # will send a POST request to `/v1/<object_name>/suspend`.
    def self.custom_method(name, http_verb:, http_path: nil)
      unless %i[get post delete].include?(http_verb)
        raise ArgumentError,
              "Invalid http_verb value: #{http_verb.inspect}. Should be one " \
              'of :get, :post or :delete.'
      end
      http_path ||= name.to_s
      define_singleton_method(name) do |id, params = {}, opts = {}|
        unless id.is_a?(String)
          raise ArgumentError,
                'id should be a string representing the ID of an API resource'
        end

        url = "#{resource_url}/#{CGI.escape(id)}/#{CGI.escape(http_path)}"
        resp, opts = request(http_verb, url, params, opts)
        Util.convert_to_supercast_object(resp.data, opts)
      end
    end

    def resource_url
      unless (id = self['id'])
        raise InvalidRequestError.new(
          "Could not determine which URL to request: #{self.class} instance " \
          "has invalid ID: #{id.inspect}",
          'id'
        )
      end
      "#{self.class.resource_url}/#{CGI.escape(id)}"
    end

    def refresh
      resp, opts = request(:get, resource_url, @retrieve_params)
      initialize_from(resp.data, opts)
    end

    def self.retrieve(id, opts = {})
      opts = Util.normalize_opts(opts)
      instance = new(id, opts)
      instance.refresh
      instance
    end
  end
end
