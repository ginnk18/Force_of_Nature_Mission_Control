class TeamsController < ApplicationController

	before_action :authorize_user!
	before_action :get_categories, only: [:new, :create]
	# before_action :find_team

	def new
    	@users=User.all
    	@team = Team.new
  	end

		def create
			@team = Team.new team_params
			if @team.save
				redirect_to team_path(@team)
			else
				render :new
			end
		end

	def index
		@teams = Team.all
		@operational_teams = Team.where(team_category: '2').order(created_at: :desc)
		@regional_teams = Team.where(team_category: '1').order(created_at: :desc)
	end

	def show
		@team = Team.find_by_id params[:id]
	

	end


	private

	# def find_team
  #
	# end

	def get_categories
		@team_categories = TeamCategory.all
	end

	def team_params
	params.require(:team).permit(:name, :team_category_id)
end

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



end
