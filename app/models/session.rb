# frozen_string_literal: true

# Session model
class Session < ApplicationRecord
  belongs_to :user
end
