# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    user
    name { Faker::String.random }

    factory :completed_task do
      completed_at { Faker::Time.backward }
    end
  end
end
