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

  # Verify that sensitive values are not exposed in serialization of the user
  # object, without otherwise affecting the behavior of
  # ActiveModel::Serialization.serializable_hash.
  describe '#serializable_hash' do
    subject { user.serializable_hash(options) }

    let(:options) { {} }

    it { is_expected.to include 'email' => user.email }
    it { is_expected.not_to include 'confirmation_token' }
    it { is_expected.not_to include 'password_digest' }

    context 'with additional :except fields' do
      let(:options) { { except: [:updated_at] } }

      it { is_expected.to include 'email' => user.email }
      it { is_expected.not_to include 'confirmation_token' }
      it { is_expected.not_to include 'password_digest' }
      it { is_expected.not_to include 'updated_at' }
    end

    context 'with protected attributes in other options' do
      let(:options) { { only: %i[confirmation_token password_digest], methods: %i[password password_confirmation] } }

      it { is_expected.not_to include 'confirmation_token' }
      it { is_expected.not_to include 'password' }
      it { is_expected.not_to include 'password_confirmation' }
      it { is_expected.not_to include 'password_digest' }
    end
  end
end
