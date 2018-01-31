class CustomEmailsController < ApplicationController
  def new
    @email = CustomEmail.new
  end

  def create
    @email = CustomEmail.new email_params
    @emailbody = email_params["email_body"]
    CustomMailer.custom_mail(@emailbody).deliver_now
  end

  private
    def email_params
    params.require(:custom_email).permit(:email_body, :to_recipients)
    end


end
