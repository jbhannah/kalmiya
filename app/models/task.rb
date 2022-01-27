# frozen_string_literal: true

# Task model
# :reek:MissingSafeMethod { exclude: [complete!] }
class Task < ApplicationRecord
  belongs_to :user

  scope :incomplete, -> { where(completed_at: nil) }
  scope :completed,  -> { inverse_of(:incomplete)  }

  broadcasts_to ->(task) { task.user }

  def complete!
    update!(completed_at: Time.zone.now) unless completed?
  end

  def completed?
    !!completed_at
  end
end
