class UsereventsController < ApplicationController

	before_action :authenticate_user!
	before_action :find_event
	before_action :authorize_user!

	def new
		@userevent = UserEvent.new
	end

	def create
		new_guests = params["user_event"]["user_id"]
		new_guests.each_with_index do |guest, index|
			if index != 0
				guest = User.find new_guests[index]
				signup = UserEvent.new(user: guest, event: @event)
				if signup.save
					EventSignUpMailer.event_sign_up(@event, guest).deliver_now
            		remind_date = DateTime.new(@event.date.year, @event.date.month, @event.date.day)
            		ReminderMailerJob.set(wait_until: remind_date).perform_later(@event,guest)
            		if index == new_guests.length - 1
            			redirect_to event_path(@event), notice: "You added #{new_guests.length - 1} new guests."
            		end
				else
					redirect_to event_path(@event), notice: "You already signed up #{guest.full_name} to this event."
					break
				end
			end
		end
	end

	def destroy
		
	end

	private

	def find_event
		@event = Event.find params[:event_id]
	end

	def authorize_user!
      if current_user.user_category.name == 'Guest' || current_user.user_category.name == 'General Volunteer'
        flash[:notice] = "Access Denied!"
        redirect_to root_path
      end
    end



end
