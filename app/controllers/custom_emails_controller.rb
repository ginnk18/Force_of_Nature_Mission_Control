class CustomEmailsController < ApplicationController
  def new
    @email = CustomEmail.new
    @event =  Event.find params[:event_id]
    @user_emails = @event.guests.collect do |event|
      event.email
    end
  end

  def create
    @email = CustomEmail.new email_params
    @emailbody = email_params["email_body"]
    @to_recipients= email_params["to_recipients"]
    CustomMailer.custom_mail(@emailbody,@to_recipients).deliver_now
  end

  private
    def email_params
    params.require(:custom_email).permit(:email_body, :to_recipients)
    end


end
