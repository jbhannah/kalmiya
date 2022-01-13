# frozen_string_literal: true

# Base ActionMailer mailer
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
