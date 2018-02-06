class ReminderMailer < ApplicationMailer

  def reminder(event, user)
  @event = event
  @user = user
  @email = @user.email
  mail(to: 'thissectionclosedcc@gmail.com', subject: "REMINDER: #{@event.name} with Force of Nature")
  end
end
