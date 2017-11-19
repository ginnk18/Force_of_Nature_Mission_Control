class EventsignupController < ApplicationController
    skip_before_action :verify_authenticity_token  
      before_action :find_event, only: [:new, :create]
    def new
    end

    def create
        email = params[:email]['email']
        p email
        user = User.find_by_email email
        if user
            signup =  UserEvent.new(user: user ,event: @event )


        else
            user = User.new(email: email, user_category_id: 1)
            user.save
            signup = UserEvent.new(user: user ,event: @event )


        end
        if signup.save
              EventSignUpMailer.event_sign_up(@event, user).deliver_now
             #ReminderMailer.reminder(@event, user).deliver_now
              #ReminderMailerJob.set(wait_until: 2.minutes.from_now).perform_later(@event)
            redirect_to events_path ,notice: 'Thanks for signing up!'
        else
            redirect_to events_path, notice: 'You have already signed up!'
        end

    end

    def modalsignup
        @event = Event.find_by google_event_id: params[:id]
        email =  params.keys[0]
        p email
        user = User.find_by_email email
        if user 
            signup =  UserEvent.new(user: user ,event: @event )
        else
            user = User.new(email: email, user_category_id: 1)
            user.save
            signup = UserEvent.new(user: user ,event: @event )
        end 
        if signup.save
            render json: { message: "Thanks for signing up!" }
        else
            render json: { message: "You have already signed up!"}
        end
    end

    private

    def find_event
         @event = Event.find params[:event_id]
    end


end
