# frozen_string_literal: true

# Remove null bytes from string attributes before model validation.
module NullByteCleaner
  extend ActiveSupport::Concern

  class_methods do
    attr_reader :cleanable_attributes

    def clean_null_bytes_from(*attrs)
      (@cleanable_attributes ||= []).push(*attrs)

      before_validation :clean_null_bytes
    end
  end

  private

  def clean_null_bytes
    self.class.cleanable_attributes.each { |attr| self[attr]&.delete!("\u0000") }
  end
end
