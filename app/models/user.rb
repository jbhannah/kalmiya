# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_token :confirmation_token
  has_secure_password
end
