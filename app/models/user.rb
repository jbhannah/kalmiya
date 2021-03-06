# frozen_string_literal: true

# User model
# :reek:MissingSafeMethod { exclude: [authenticate!, find_and_authenticate_by!] }
class User < ApplicationRecord
  include NullByteCleaner
  include ProtectedAttributes

  has_secure_token :confirmation_token
  has_secure_password

  has_many :sessions, dependent: :delete_all
  has_many :tasks, dependent: :delete_all

  before_validation :downcase_email

  validates :email, presence: true, uniqueness: true

  clean_null_bytes_from :email, :password, :password_confirmation

  protect_attributes :confirmation_token, :password, :password_confirmation, :password_digest

  class << self
    def find_and_authenticate_by!(email:, password:)
      find_by!(email:).authenticate!(password)
    rescue ActiveRecord::RecordNotFound
      raise Kalmiya::Errors::UserAuthenticationError
    end
  end

  def authenticate!(password)
    authenticate(password) or raise Kalmiya::Errors::UserAuthenticationError
  end

  def use_time_zone(&)
    Time.use_zone(time_zone, &)
  end

  private

  def downcase_email
    email&.downcase!
  end
end
