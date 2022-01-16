# frozen_string_literal: true

module HTTP
  # Classes that represent HTTP error statuses. These are instantiated by being
  # thrown as errors, and may not refer to self nor have any instance variables.
  module Errors
    # Base class for HTTP error statuses.
    class BaseError < StandardError
      def code
        raise NotImplementedError
      end
    end

    # Represents an HTTP 401 Unauthorized error.
    class UnauthorizedError < BaseError
      def code
        :unauthorized
      end
    end
  end
end
