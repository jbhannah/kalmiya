# frozen_string_literal: true

key = Rails.root.join('config/master.key')

namespace :docker do
  namespace :build do
    task production: :environment do
      `docker build -t kalmiya:latest --secret id=masterkey,src=#{key} .`
    end

    task test: :environment do
      `docker build -t kalmiya:latest-test --build-arg RAILS_ENV=test --secret id=masterkey,src=#{key} .`
    end

    task all: %w[production test]
  end

  task build: ['build:production']
end
