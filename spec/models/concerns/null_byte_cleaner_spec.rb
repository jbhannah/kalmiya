# frozen_string_literal: true

require 'rails_helper'

# Sample model that implements NullByteCleaner.
# :reek:BooleanParameter
class NullByteCleaned
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  include NullByteCleaner

  attr_reader :name, :body, :clean

  validates_format_of :name, without: /\u0000/

  clean_null_bytes_from :name

  skip_callback :validation, :before, :clean_null_bytes, unless: :clean

  def initialize(name:, body:, clean: true)
    @name = name
    @body = body
    @clean = clean
  end

  def [](attr)
    send(attr)
  end
end

RSpec.describe NullByteCleaner do
  subject(:model) { NullByteCleaned.new name: dirty_name, body: dirty_name, clean: clean }

  let(:clean_name) { Faker::Name.name }
  let(:dirty_name) { clean_name.clone.insert(clean_name.length / 2, "\u0000") }

  before { model.validate }

  context 'when not validated' do
    let(:clean) { false }

    it { is_expected.not_to be_valid }
    it { is_expected.to have_attributes name: dirty_name, body: dirty_name }
  end

  context 'when validated' do
    let(:clean) { true }

    it { is_expected.to be_valid }
    it { is_expected.to have_attributes name: clean_name, body: dirty_name }
  end
end
