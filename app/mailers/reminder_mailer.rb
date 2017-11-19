class ReminderMailer < ApplicationMailer

  def reminder(event, user)
  @event = event
  @user = user
  mail(to: 'Brandoneverell@hotmail.com', subject: 'Event Reminder')
  end
end
