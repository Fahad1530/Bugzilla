# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'fahad.murtaza@devsinc.com'
  layout 'mailer'
end
