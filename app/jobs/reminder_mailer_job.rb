class ReminderMailerJob < ApplicationJob
  queue_as :default
  #
  def perform(event, user)
    ReminderMailer.reminder(@event, user)
    # Do something later
  end
end
