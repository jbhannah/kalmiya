# frozen_string_literal: true

# Session model
class Session < ApplicationRecord
  belongs_to :user
  scope :active, -> { where(expires_at: Time.zone.now..) }
  scope :expired, -> { inverse_of(:active) }
end
