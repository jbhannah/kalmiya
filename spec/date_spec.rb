# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Date do
  describe '#mweek' do
    subject { date.mweek }

    context 'when date is Monday, 4 April 2022' do
      let(:date) { described_class.new(2022, 4, 4) }

      it { is_expected.to eq(0) }
    end

    context 'when date is Monday, 11 April 2022' do
      let(:date) { described_class.new(2022, 4, 11) }

      it { is_expected.to eq(1) }
    end

    context 'when date is Monday, 18 April 2022' do
      let(:date) { described_class.new(2022, 4, 18) }

      it { is_expected.to eq(2) }
    end

    context 'when date is Monday, 25 April 2022' do
      let(:date) { described_class.new(2022, 4, 25) }

      it { is_expected.to eq(3) }
    end

    context 'when date is Saturday, 30 April 2022' do
      let(:date) { described_class.new(2022, 4, 30) }

      it { is_expected.to eq(4) }
    end
  end

  describe '#nth_kday' do
    subject(:nth_kday) { date.nth_kday(nth, kday) }

    let(:date) { described_class.new(2022, 4, 11) }

    context 'when nth kday is first Monday of April 2022' do
      let(:nth) { 0 }
      let(:kday) { :monday }

      it { is_expected.to eq(described_class.new(2022, 4, 4)) }
    end

    context 'when nth kday is fifth Saturday of April 2022' do
      let(:nth) { 4 }
      let(:kday) { :saturday }

      it { is_expected.to eq(described_class.new(2022, 4, 30)) }
    end

    context 'when nth kday is fifth Sunday of April 2022' do
      let(:nth) { 4 }
      let(:kday) { :sunday }

      it { expect { nth_kday }.to raise_error(Date::Error) }
    end

    context 'when nth kday is sixth Sunday of April 2022' do
      let(:nth) { 5 }
      let(:kday) { :sunday }

      it { expect { nth_kday }.to raise_error(Date::Error) }
    end
  end
end
