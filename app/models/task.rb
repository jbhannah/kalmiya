# frozen_string_literal: true

# Task model
class Task < ApplicationRecord
  belongs_to :user

  broadcasts_to ->(task) { task.user }
end
