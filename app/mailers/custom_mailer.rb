class CustomMailer < ApplicationMailer
  def custom_mail(body, email, subject, event)
  @event = event
  @email = email
  @subject = subject
  @body = body
  mail(bcc: @email, subject: @subject)
  end
end
