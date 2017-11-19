class TeamsController < ApplicationController

	before_action :authorize_user!

	def index
		@operational_teams = Team.where(team_category: '2').order(created_at: :desc)
		@regional_teams = Team.where(team_category: '1').order(created_at: :desc)
	end


	private

	def authorize_user!
		if current_user
			unless current_user.user_category.name == 'Admin'
				flash[:alert] = 'Access denied sucka!'
				redirect_to root_path
			end
		else
			flash[:alert] = 'Access denied.'
			redirect_to root_path
		end
	end

end


