class EventsignupController < ApplicationController
      before_action :find_event, only: [:new, :create]
    def new
    end

    def create
        user = User.find_by email:params[:email]["Email:"]
        if user 
            signup = UserEvent.new(user: user ,event: @event )
        else
            user = User.new(email: :email)
            signup = UserEvent.new(user: user ,event: @event )
        end 

        if signup.save
             redirect_to events, notice: 'Thanks for liking!'
        else
            redirect_to events, notice: 'You have already signed up!'
        end
    end

    private
    def find_event
         @event = Event.find params[:event_id] 
    end


end
