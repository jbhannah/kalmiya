# frozen_string_literal: true

Rails.root.glob('lib/core_extensions/**/*.rb').each do |file|
  require file
end
