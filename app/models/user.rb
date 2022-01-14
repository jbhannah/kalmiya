# frozen_string_literal: true

# User model
# :reek:MissingSafeMethod { exclude: [authenticate!] }
class User < ApplicationRecord
  include ProtectedAttributes

  has_secure_token :confirmation_token
  has_secure_password

  has_many :sessions, dependent: :delete_all

  before_validation :downcase_email

  validates :email, presence: true, uniqueness: true

  protect_attributes :confirmation_token, :password, :password_confirmation, :password_digest

  def authenticate!(password)
    authenticate(password) || raise
  end

  private

  def downcase_email
    email&.downcase!
  end
end
