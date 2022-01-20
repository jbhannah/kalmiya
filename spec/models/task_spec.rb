# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  subject(:task) { build(:task) }

  it { is_expected.to be_valid }
end
