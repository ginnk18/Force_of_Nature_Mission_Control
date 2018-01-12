class UsereventsController < ApplicationController

	before_action :authenticate_user!
	before_action :find_event
	before_action :authorize_user!

	def new
		@userevent = UserEvent.new
	end

	def create
		new_guests = params["user_event"]["user_id"]
		if new_guests.length == 3
			guest1 = User.find new_guests[1]
			guest2 = User.find new_guests[2]
		end
		render json: guest1
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

# def event_params
#     # With this method, we will extract the parameters related to
#     # question from the `params` object. And, we'll only permit
#     # fields of our choice. In this case, we specifically permit
#     # the fields we allow the user to edit in the new_question form.
#     params.require(:event).permit(
#       :name,:date,:start_time,:end_time,
#       :location,:additional_info,:attachment_url,
#       :event_category_id,:lead_id, :team_id,:data_captain_id,:sign_up_goals,
#       :show_up_goals,:signature_goals, :sign_up_outcome, :show_up_outcome, :signature_outcome)
#     # The `params` object is available inside all controllers. It's
#     # a "hash" that holds all URL params, all fields from the form and
#     # all query params. It's as if we merged `request.query`, `request.params`
#     # and `request.body` from Express into one object.
#   end
