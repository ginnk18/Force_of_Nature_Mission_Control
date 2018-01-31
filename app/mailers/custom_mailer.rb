class CustomMailer < ApplicationMailer
  def custom_mail(body, email)
  @email = email
  @body = body
  mail(bcc: @email, subject: 'Welcome to Force of Nature Mission Control!')
  end
end
