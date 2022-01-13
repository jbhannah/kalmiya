# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_token :confirmation_token
  has_secure_password

  has_many :sessions, dependent: :delete_all

  before_validation :downcase_email

  validates :email, presence: true, uniqueness: true

  private

  def downcase_email
    email&.downcase!
  end
end
