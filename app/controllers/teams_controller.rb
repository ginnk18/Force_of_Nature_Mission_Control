class TeamsController < ApplicationController
	before_action :authorize_user!
	before_action :find_team, only: [:show]

	def new
    	@users=User.all
    	@team = Team.new
  	end

	def index
		@operational_teams = Team.where(team_category: '2').order(created_at: :desc)
		@regional_teams = Team.where(team_category: '1').order(created_at: :desc)
	end

	def show
	end


	private

	def authorize_user!
		if current_user
			unless current_user.user_category.name == 'Team Lead' || current_user.user_category.name == 'Admin'
				flash[:alert] = 'Access denied sucka!'
				redirect_to root_path
			end
		else
			flash[:alert] = 'Please sign in first.'
			redirect_to new_session_path
		end
	end

	def find_team
		@team = Team.find params[:id]
	end

end

