class EventSignUpMailer < ApplicationMailer

def event_sign_up(event, user)
@event = event
@user = user
mail(to: 'Brandoneverell@hotmail.com', subject: 'Event Sign Up')
end

end
