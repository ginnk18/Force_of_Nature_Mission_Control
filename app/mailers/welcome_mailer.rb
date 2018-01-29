class WelcomeMailer < ApplicationMailer

  def welcome_user(user)
    @user = user
    @email = @user.email
    mail(to: @email, subject: 'Welcome to Force of Nature Mission Control!')
  end

 def approved(user)
       @user = user
       @email = @user.email
       mail(to: @email, subject: 'Welcome to Force of Nature Mission Control!')
 end

end
