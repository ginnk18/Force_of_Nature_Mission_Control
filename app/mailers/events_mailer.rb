class EventsMailer < ApplicationMailer

def notify_event_creator(event)
  @event = event
  @event_owner = User.find @event.creator_id
  @email = @event_owner.email
  mail(to: @email, subject: "You created an event: #{@event.name}")
  end
end
