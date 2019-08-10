# frozen_string_literal: true

module Supercast
  class UsageAlert < Resource
    extend Supercast::Operations::List

    OBJECT_NAME = 'usage_alert'.freeze

    custom_method :dismiss, http_verb: :patch
    custom_method :ignore, http_verb: :patch
    custom_method :suspend, http_verb: :patch

    def dismiss(params = {}, opts = {})
      resp, opts = request(:patch, resource_url + '/dismiss', params, opts)
      initialize_from(resp.data, opts)
    end

    def ignore(params = {}, opts = {})
      resp, opts = request(:patch, resource_url + '/ignore', params, opts)
      initialize_from(resp.data, opts)
    end

    def suspend(params = {}, opts = {})
      resp, opts = request(:patch, resource_url + '/suspend', params, opts)
      initialize_from(resp.data, opts)
    end
  end
end
