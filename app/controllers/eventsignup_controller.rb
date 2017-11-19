class EventsignupController < ApplicationController
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
            redirect_to events_path ,notice: 'Thanks for signing up!'
        else
            redirect_to events_path, notice: 'You have already signed up!'
        end
        
    end

    private

    def find_event
         @event = Event.find params[:event_id] 
    end


end
