# frozen_string_literal: true

# Supercast Ruby bindings
require 'cgi'
require 'faraday'
require 'json'
require 'logger'
require 'openssl'
require 'rbconfig'
require 'securerandom'
require 'set'
require 'socket'
require 'uri'

# Version
require_relative 'supercast/version'

# API operations
require_relative 'supercast/operations/create'
require_relative 'supercast/operations/destroy'
require_relative 'supercast/operations/list'
require_relative 'supercast/operations/request'
require_relative 'supercast/operations/save'
require_relative 'supercast/operations/feeds'

# API resource support classes
require_relative 'supercast/errors'
require_relative 'supercast/client'
require_relative 'supercast/data_types'
require_relative 'supercast/util'
require_relative 'supercast/data_object'
require_relative 'supercast/response'
require_relative 'supercast/data_list'
require_relative 'supercast/resource'
require_relative 'supercast/singleton'

# Named API resources
require_relative 'supercast/resources'

module Supercast
  DEFAULT_CA_BUNDLE_PATH ||= __dir__ + '/data/ca-certificates.crt'

  @api_base = 'https://supercast.tech/api'
  @api_version = 'v1'

  @log_level = nil
  @logger = nil

  @proxy = nil

  @max_network_retries = 0
  @max_network_retry_delay = 2
  @initial_network_retry_delay = 0.5

  @ca_bundle_path = DEFAULT_CA_BUNDLE_PATH
  @ca_store = nil
  @verify_ssl_certs = true

  @open_timeout = 30
  @read_timeout = 80

  class << self
    attr_accessor :api_key, :api_base, :verify_ssl_certs,
                  :api_version, :open_timeout, :read_timeout, :proxy

    attr_reader :max_network_retry_delay, :initial_network_retry_delay
  end

  # The location of a file containing a bundle of CA certificates. By default
  # the library will use an included bundle that can successfully validate
  # Supercast certificates.
  def self.ca_bundle_path
    @ca_bundle_path
  end

  def self.ca_bundle_path=(path)
    @ca_bundle_path = path

    # empty this field so a new store is initialized
    @ca_store = nil
  end

  # A certificate store initialized from the the bundle in #ca_bundle_path and
  # which is used to validate TLS on every request.
  #
  # This was added to the give the gem "pseudo thread safety" in that it seems
  # when initiating many parallel requests marshaling the certificate store is
  # the most likely point of failure. Any program attempting
  # to leverage this pseudo safety should make a call to this method (i.e.
  # `Supercast.ca_store`) in their initialization code because it marshals lazily
  # and is itself not thread safe.
  def self.ca_store
    @ca_store ||= begin
      store = OpenSSL::X509::Store.new
      store.add_file(ca_bundle_path)
      store
    end
  end

  # Map to the same values as the standard library's logger
  LEVEL_DEBUG ||= Logger::DEBUG
  LEVEL_ERROR ||= Logger::ERROR
  LEVEL_INFO ||= Logger::INFO

  # When set prompts the library to log some extra information to $stdout and
  # $stderr about what it's doing. For example, it'll produce information about
  # requests, responses, and errors that are received. Valid log levels are
  # `debug` and `info`, with `debug` being a little more verbose in places.
  #
  # Use of this configuration is only useful when `.logger` is _not_ set. When
  # it is, the decision what levels to print is entirely deferred to the logger.
  def self.log_level
    @log_level
  end

  def self.log_level=(val)
    raise ArgumentError, 'log_level should only be set to `nil`, `debug` or `info`' if !val.nil? && ![LEVEL_DEBUG, LEVEL_ERROR, LEVEL_INFO].include?(val)

    @log_level = val
  end

  # Sets a logger to which logging output will be sent. The logger should
  # support the same interface as the `Logger` class that's part of Ruby's
  # standard library (hint, anything in `Rails.logger` will likely be
  # suitable).
  #
  # If `.logger` is set, the value of `.log_level` is ignored. The decision on
  # what levels to print is entirely deferred to the logger.
  def self.logger
    @logger
  end

  def self.logger=(val)
    @logger = val
  end

  def self.max_network_retries
    @max_network_retries
  end

  def self.max_network_retries=(val)
    @max_network_retries = val.to_i
  end
end

Supercast.log_level = ENV['SUPERCAST_LOG'] unless ENV['SUPERCAST_LOG'].nil?
