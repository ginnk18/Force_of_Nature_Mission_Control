class ReminderMailerJob < ApplicationJob
  queue_as :default
  #
  def perform(event, user)
  	@event = event
  	@user = user
    ReminderMailer.reminder(@event, @user)
    # Do something later
  end
end
