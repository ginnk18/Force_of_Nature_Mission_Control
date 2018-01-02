class ReminderMailer < ApplicationMailer

  def reminder(event, user)
  @event = event
  @user = user
  mail(to: 'thissectionclosedcc@gmail.com', subject: 'Event Reminder')
  end
end
