# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    user
    name { Faker::String.random }

    # factory :completed_task do
    #   completed_at { Faker::Time.backward }
    # end

    trait :completed do
      completed_at { Faker::Time.backward }
    end

    trait :due do
      due_on { Faker::Date.forward }
    end

    trait :due_today do
      due_on { user.use_time_zone { Time.zone.today } }
    end

    trait :overdue do
      due_on { Faker::Date.backward }
    end

    factory :completed_task, traits: %i[completed]
  end
end
