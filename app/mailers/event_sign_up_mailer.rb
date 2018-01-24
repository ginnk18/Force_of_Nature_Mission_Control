class EventSignUpMailer < ApplicationMailer

def event_sign_up(event, user)
@event = event
@user = user
@email = @user.email
mail(to: @email, subject: 'You signed up with Force of Nature')
end

end
