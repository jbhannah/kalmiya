# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it { is_expected.to be_valid }

  describe '#downcase_email' do
    subject { user.email }

    let(:email) { Faker::Internet.email.upcase }

    before do
      user.email = email
      user.validate
    end

    it { is_expected.not_to match(/[A-Z]/) }
  end
end
