# frozen_string_literal: true

module Supercast
  class Singleton < Resource
    def self.resource_url
      if self == Singleton
        raise NotImplementedError,
              'Singleton is an abstract class. You should ' \
              'perform actions on its subclasses (Balance, etc.)'
      end

      "/#{self::OBJECT_NAME.downcase}"
    end

    def self.retrieve(opts = {})
      instance = new(nil, Util.normalize_opts(opts))
      instance.refresh
      instance
    end

    def resource_url
      self.class.resource_url
    end
  end
end
