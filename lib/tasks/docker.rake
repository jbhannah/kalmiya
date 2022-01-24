namespace :docker do
  task build: :environment do
    key = Rails.root.join("config", "master.key")
    `docker build -t kalmiya:latest --secret id=masterkey,src=#{key} .`
  end
end
