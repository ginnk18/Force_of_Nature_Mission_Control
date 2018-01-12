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
            		redirect_to event_path(@event), notice: "You added #{new_guests.length - 1} new guests."
				else
					redirect_to event_path(@event), notice: "You already signed up #{guest.full_name} to this event."
					break
				end
			end
		end
		# if new_guests.length == 3
		# 	guest1 = User.find new_guests[1]
		# 	guest2 = User.find new_guests[2]
		# 	signup1 = UserEvent.new(user: guest1, event: @event)
		# 	signup2 = UserEvent.new(user: guest2, event: @event)
		# 	if signup1.save && signup2.save 
		# 		EventSignUpMailer.event_sign_up(@event, guest1).deliver_now
		# 		EventSignUpMailer.event_sign_up(@event, guest2).deliver_now
  #           	remind_date = DateTime.new(@event.date.year, @event.date.month, @event.date.day)
  #           	ReminderMailerJob.set(wait_until: remind_date).perform_later(@event,guest1)
  #           	ReminderMailerJob.set(wait_until: remind_date).perform_later(@event,guest2)
  #           	redirect_to event_path(@event), notice: "You added #{new_guests.length - 1} new guests." 
		# 	else
		# 		redirect_to event_path(@event), notice: 'You already signed up those users to this event.' 
		# 	end
		# end

	end

	def destroy
		
	end

	private

	def find_event
		@event = Event.find params[:event_id]
	end

	def authorize_user!
		admin = UserCategory.where(name: 'Admin')
		team_lead = UserCategory.where(name: 'Team Lead')
      if current_user.user_category.name == 'Guest' || current_user.user_category.name == 'General Volunteer'
        flash[:notice] = "Access Denied!"
        redirect_to root_path
      end
    end



end

#########

# if user
#             signup = UserEvent.new(user: user, event: @event )
#         else
#             user = User.new(
#                     first_name: first_name,
#                     last_name: last_name,
#                     email: email,
#                     phone_number: phone_number,
#                     additional_info: additional_info,
#                     previous_volunteer: previous_volunteer
#                 )
#             # puts 'THIS IS THE NEWLY CREATED USER: '
#             # puts user.first_name
#             user.save!
#             signup = UserEvent.new(user: user, event: @event )
#         end

#         if signup.save
