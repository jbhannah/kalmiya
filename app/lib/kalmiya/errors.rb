# frozen_string_literal: true

module Kalmiya
  # Classes that represent non-exception application errors. These are
  # instantiated by being thrown as errors, and may not refer to self nor have
  # any instance variables.
  module Errors
    # Represents a user authentication failure, due to either not finding a user
    # for the given email address, or a credential matching failure. The
    # underlying cause is not exposed to the user, to minimze risk of
    # password-reuse attacks by obscuring whether an account exists for the given
    # email address.
    class UserAuthenticationError < StandardError; end
  end
end
