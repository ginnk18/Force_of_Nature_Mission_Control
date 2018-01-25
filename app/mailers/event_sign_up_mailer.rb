class EventSignUpMailer < ApplicationMailer

def event_sign_up(event, user)
@event = event
@user = user
@email = @user.email
mail(to: @email, subject: "You signed up for #{@event.name} with Force of Nature")
end

end
