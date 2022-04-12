# frozen_string_literal: true

Dir.glob(Rails.root.join('lib/core_extensions/**/*.rb')).each do |file|
  require file
end
