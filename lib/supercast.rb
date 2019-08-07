# frozen_string_literal: true

# Stripe Ruby bindings
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
require 'stripe/version'

# API operations
require 'stripe/api_operations/create'
require 'stripe/api_operations/destroy'
require 'stripe/api_operations/list'
require 'stripe/api_operations/request'
require 'stripe/api_operations/save'

# API resource support classes
require 'stripe/errors'
require 'stripe/object_types'
require 'stripe/util'
require 'stripe/stripe_client'
require 'stripe/stripe_object'
require 'stripe/stripe_response'
require 'stripe/list_object'
require 'stripe/api_resource'
require 'stripe/singleton_api_resource'
require 'stripe/webhook'

# Named API resources
require 'stripe/resources'

# OAuth
require 'stripe/oauth'

module Supercast
  @api_base = 'https://supercast.com'

  @log_level = nil
  @logger = nil

  class << self
    attr_accessor :api_key, :api_base, :api_version, :client_id

    attr_reader :max_network_retry_delay, :initial_network_retry_delay
  end

  # Map to the same values as the standard library's logger
  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

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
end

Supercast.log_level = ENV['SUPERCAST_LOG'] unless ENV['SUPERCAST_LOG'].nil?
