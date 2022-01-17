# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    user { nil }
    name { 'MyString' }
    completed_at { '2022-01-16 17:43:38' }
  end
end
