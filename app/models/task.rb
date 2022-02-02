# frozen_string_literal: true

# Task model
# :reek:MissingSafeMethod { exclude: [complete!] }
class Task < ApplicationRecord
  include NullByteCleaner

  belongs_to :user

  scope :incomplete, -> { where(completed_at: nil) }
  scope :completed,  -> { inverse_of(:incomplete)  }

  scope :overdue, -> { where(due_on: ...Time.zone.today) }

  broadcasts_to ->(task) { task.user }

  clean_null_bytes_from :name

  def complete!
    update!(completed_at: Time.zone.now) unless completed?
  end

  def completed?
    !!completed_at
  end

  def completed=(value)
    self.completed_at = !!value ? (completed_at or Time.zone.now) : nil
  end

  def overdue?
    (due_on&.< Time.zone.today) and !completed?
  end
end
