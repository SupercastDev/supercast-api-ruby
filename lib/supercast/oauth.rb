# frozen_string_literal: true

module Supercast
  module OAuth
    module OAuthOperations
      extend APIOperations::Request::ClassMethods

      def self.request(method, url, params, opts)
        opts = Util.normalize_opts(opts)
        opts[:client] ||= SupercastClient.active_client
        opts[:api_base] ||= Supercast.connect_base

        super(method, url, params, opts)
      end
    end

    def self.get_client_id(params = {})
      client_id = params[:client_id] || Supercast.client_id
      unless client_id
        raise AuthenticationError, 'No client_id provided. ' \
          'Set your client_id using "Supercast.client_id = <CLIENT-ID>". ' \
          'You can find your client_ids in your Supercast dashboard ' \
          'after registering your channel. See ' \
          'https://docs.supercast.tech/docs/access-tokens for details, ' \
          'or email support@supercast.com if you have any questions.'
      end
      client_id
    end

    def self.authorize_url(params = {}, opts = {})
      base = opts[:connect_base] || Supercast.connect_base

      path = '/oauth/authorize'

      params[:client_id] = get_client_id(params)
      params[:response_type] ||= 'code'
      query = Util.encode_parameters(params)

      "#{base}#{path}?#{query}"
    end

    def self.token(params = {}, opts = {})
      opts = Util.normalize_opts(opts)
      resp, opts = OAuthOperations.request(
        :post, '/oauth/token', params, opts
      )
      # This is just going to return a generic SupercastObject, but that's okay
      Util.convert_to_supercast_object(resp.data, opts)
    end

    def self.deauthorize(params = {}, opts = {})
      opts = Util.normalize_opts(opts)
      params[:client_id] = get_client_id(params)
      resp, opts = OAuthOperations.request(
        :post, '/oauth/deauthorize', params, opts
      )
      # This is just going to return a generic SupercastObject, but that's okay
      Util.convert_to_supercast_object(resp.data, opts)
    end
  end
end
