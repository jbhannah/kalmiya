# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a not-overdue task' do |due_on|
  let(:due_on) { due_on }

  it { is_expected.not_to be_overdue }
end

RSpec.shared_examples 'an overdue task' do |due_on|
  let(:due_on) { due_on }

  it { is_expected.to be_overdue }
end

RSpec.describe Task, type: :model do
  subject(:task) { incomplete_task }

  let!(:completed_task)  { create(:completed_task)   }
  let!(:incomplete_task) { create(:task)             }
  let!(:due_task)        { create(:task, :due)       }
  let!(:due_today_task)  { create(:task, :due_today) }
  let!(:overdue_task)    { create(:task, :overdue)   }

  it { is_expected.to be_valid }

  describe 'class methods' do
    describe '.completed' do
      subject { described_class.completed }

      it { is_expected.to     include completed_task  }
      it { is_expected.not_to include incomplete_task }
    end

    describe '.incomplete' do
      subject { described_class.incomplete }

      it { is_expected.to     include incomplete_task }
      it { is_expected.not_to include completed_task  }
    end

    describe '.overdue' do
      subject { described_class.overdue }

      it { is_expected.to     include overdue_task    }
      it { is_expected.not_to include due_task        }
      it { is_expected.not_to include due_today_task  }
      it { is_expected.not_to include completed_task  }
      it { is_expected.not_to include incomplete_task }
    end
  end

  describe '#complete!' do
    let(:time) { Faker::Time.backward }

    before do
      travel_to time
      task.complete!
    end

    context 'when completed_at is null' do
      it { is_expected.to be_completed                       }
      it { is_expected.to have_attributes completed_at: time }
    end

    context 'when completed_at is not null' do
      let(:task) { completed_task }
      let(:time) { Faker::Time.between(from: task.completed_at + 1.second, to: Time.zone.now) }

      it { is_expected.to     be_completed                                              }
      it { is_expected.to     have_attributes completed_at: completed_task.completed_at }
      it { is_expected.not_to have_attributes completed_at: time                        }
    end
  end

  describe '#completed?' do
    context 'when completed_at is null' do
      it { is_expected.not_to be_completed }
    end

    context 'when completed_at is not null' do
      subject(:completed_task) { create(:completed_task) }

      it { is_expected.to be_completed }
    end
  end

  describe '#overdue?' do
    around do |example|
      task.user.use_time_zone(&example)
    end

    before { task.due_on = due_on }

    context 'when incomplete' do
      it_behaves_like 'a not-overdue task', nil
      it_behaves_like 'a not-overdue task', Faker::Date.forward
      it_behaves_like 'a not-overdue task', Time.zone.today
      it_behaves_like 'an overdue task', Faker::Date.backward
    end

    context 'when completed' do
      let(:task) { completed_task }

      it_behaves_like 'a not-overdue task', nil
      it_behaves_like 'a not-overdue task', Faker::Date.forward
      it_behaves_like 'a not-overdue task', Time.zone.today
      it_behaves_like 'a not-overdue task', Faker::Date.backward
    end
  end
end
