class WelcomeMailer < ApplicationMailer

  def welcome_user(user)
    @user = user
    mail(to: 'Brandoneverell@hotmail.com', subject: 'Welcome!')
  end
end
