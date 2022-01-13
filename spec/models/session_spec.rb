# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Session, type: :model do
  subject(:session) { active_session }

  let!(:active_session) { create(:session) }
  let!(:expired_session) { create(:expired_session) }

  it { is_expected.to be_valid }

  describe 'class methods' do
    describe '.active' do
      subject { described_class.active }

      it { is_expected.to include active_session }
      it { is_expected.not_to include expired_session }
    end

    describe '.expired' do
      subject { described_class.expired }

      it { is_expected.not_to include active_session }
      it { is_expected.to include expired_session }
    end
  end
end
