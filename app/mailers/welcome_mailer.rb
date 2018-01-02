class WelcomeMailer < ApplicationMailer

  def welcome_user(user)
    @user = user
    mail(to: 'thissectionclosedcc@gmail.com', subject: 'Welcome!')
  end
end
