class CustomMailer < ApplicationMailer
  def custom_mail(body)
  @body = body
  mail(to: @email, subject: 'Welcome to Force of Nature Mission Control!')
  end
end
