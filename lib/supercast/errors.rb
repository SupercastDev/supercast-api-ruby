# frozen_string_literal: true

module Supercast
  # SupercastError is the base error from which all other more specific Supercast
  # errors derive.
  class SupercastError < StandardError
    attr_reader :message

    # Response contains a SupercastResponse object that has some basic information
    # about the response that conveyed the error.
    attr_accessor :response

    attr_reader :code
    attr_reader :http_body
    attr_reader :http_headers
    attr_reader :http_status
    attr_reader :json_body # equivalent to #data

    # Initializes a SupercastError.
    def initialize(message = nil, http_status: nil, http_body: nil, json_body: nil, http_headers: nil, code: nil)
      @message = message
      @http_status = http_status
      @http_body = http_body
      @http_headers = http_headers || {}
      @json_body = json_body
      @code = code
    end

    def to_s
      status_string = @http_status.nil? ? '' : "(Status #{@http_status}) "
      "#{status_string}#{@message}"
    end
  end

  # AuthenticationError is raised when invalid credentials are used to connect
  # to Supercast's servers.
  class AuthenticationError < SupercastError
  end

  # APIConnectionError is raised in the event that the SDK can't connect to
  # Supercast's servers. That can be for a variety of different reasons such as a
  # downed network
  class APIConnectionError < SupercastError
  end

  # APIError is a generic error that may be raised in cases where none of the
  # other named errors cover the problem. It could also be raised in the case
  # that a new error has been introduced in the API, but this version of the
  # Ruby SDK doesn't know how to handle it.
  class APIError < SupercastError
  end

  # InvalidRequestError is raised when a request is initiated with invalid
  # parameters.
  class InvalidRequestError < SupercastError
    attr_accessor :param

    def initialize(message, param, http_status: nil, http_body: nil, json_body: nil, http_headers: nil, code: nil)
      super(message, http_status: http_status, http_body: http_body,
                     json_body: json_body, http_headers: http_headers,
                     code: code)
      @param = param
    end
  end

  # PermissionError is raised in cases where access was attempted on a resource
  # that wasn't allowed.
  class PermissionError < SupercastError
  end

  # RateLimitError is raised in cases where an account is putting too much load
  # on Supercast's API servers (usually by performing too many requests). Please
  # back off on request rate.
  class RateLimitError < SupercastError
  end

  module OAuth
    # OAuthError is raised when the OAuth API returns an error.
    class OAuthError < SupercastError
      def initialize(code, description, http_status: nil, http_body: nil, json_body: nil, http_headers: nil)
        super(description, http_status: http_status, http_body: http_body,
                           json_body: json_body, http_headers: http_headers,
                           code: code)
      end
    end

    # InvalidClientError is raised when the client doesn't belong to you or it
    # doesn't exist or isn't connected to your application.
    class InvalidClientError < OAuthError
    end

    # InvalidGrantError is raised when a specified code doesn't exist, is
    # expired, has been used, or doesn't belong to you; a refresh token doesn't
    # exist, or doesn't belong to you.
    class InvalidGrantError < OAuthError
    end

    # InvalidRequestError is raised when a code, refresh token, or grant type
    # parameter is not provided, but was required.
    class InvalidRequestError < OAuthError
    end

    # InvalidScopeError is raised when an invalid scope parameter is provided.
    class InvalidScopeError < OAuthError
    end

    # UnsupportedGrantTypeError is raised when an unuspported grant type
    # parameter is specified.
    class UnsupportedGrantTypeError < OAuthError
    end

    # UnsupportedResponseTypeError is raised when an unsupported response type
    # parameter is specified.
    class UnsupportedResponseTypeError < OAuthError
    end
  end
end
