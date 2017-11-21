class EventsMailer < ApplicationMailer

def notify_event_creator(event)
  @event = event
  @event_owner = @event.creator_id
  mail(to: 'thissectionclosedcc@gmail.com', subject: 'Your created event ')
  end
end
