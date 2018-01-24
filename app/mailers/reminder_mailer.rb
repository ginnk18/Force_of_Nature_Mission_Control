class ReminderMailer < ApplicationMailer

  def reminder(event, user)
  @event = event
  @user = user
  @email = @user.email
  mail(to: @email, subject: "REMINDER: #{@event.name} with Force of Nature")
  end
end
