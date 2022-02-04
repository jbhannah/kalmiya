# frozen_string_literal: true

# Specify attributes to explicitly cast to strings before serialization.
module StringifiedAttributes
  extend ActiveSupport::Concern

  class_methods do
    attr_reader :stringified_attributes

    def stringify_attributes_for_serialization(*args)
      (@stringified_attributes ||= []).push(*args)
    end
  end

  protected

  def read_attribute_for_serialization(key)
    if stringified_attributes.include?(key)
      send(key).to_s
    else
      super
    end
  end
end
