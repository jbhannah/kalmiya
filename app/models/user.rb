# frozen_string_literal: true

# Represents a user authentication failure, due to either not finding a user for
# the given email address, or a credential matching failure. The underlying
# cause is not exposed to the user, to minimze risk of password-reuse attacks by
# obscuring whether an account exists for the given email address.
class UserAuthenticationError < StandardError; end

# User model
# :reek:MissingSafeMethod { exclude: [authenticate!, find_and_authenticate_by!] }
class User < ApplicationRecord
  include ProtectedAttributes

  has_secure_token :confirmation_token
  has_secure_password

  has_many :sessions, dependent: :delete_all

  before_validation :downcase_email

  validates :email, presence: true, uniqueness: true

  protect_attributes :confirmation_token, :password, :password_confirmation, :password_digest

  class << self
    def find_and_authenticate_by!(email:, password:)
      find_by!(email:).authenticate!(password)
    rescue ActiveRecord::RecordNotFound
      raise UserAuthenticationError
    end
  end

  def authenticate!(password)
    authenticate(password) or raise UserAuthenticationError
  end

  private

  def downcase_email
    email&.downcase!
  end
end
