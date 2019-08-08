# frozen_string_literal: true

module Supercast
  class Singleton < Resource
    def self.resource_url
      if self == Singleton
        raise NotImplementedError,
              'Singleton is an abstract class. You should ' \
              'perform actions on its subclasses (Balance, etc.)'
      end

      # Namespaces are separated in object names with periods (.) and in URLs
      # with forward slashes (/), so replace the former with the latter.
      "/#{self::OBJECT_NAME.downcase.tr('.', '/')}"
    end

    def resource_url
      self.class.resource_url
    end

    def self.retrieve(opts = {})
      instance = new(nil, Util.normalize_opts(opts))
      instance.refresh
      instance
    end
  end
end
