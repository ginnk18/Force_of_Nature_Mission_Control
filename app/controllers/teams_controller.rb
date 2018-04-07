class TeamsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_categories, only: [:new, :create, :edit]
	before_action :get_users
	before_action :authorize_user!, except: [:index, :show]

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
			@operation_category = TeamCategory.where(name: 'Operational').first
			@regional_category = TeamCategory.where(name: 'Regional').first
			@operational_teams = Team.where(team_category: @operation_category).order(created_at: :desc)
			@regional_teams = Team.where(team_category: @regional_category).order(created_at: :desc)
		end

	def show
		@team = Team.find_by_id params[:id]
	end

	def edit
		@team = Team.find_by_id params[:id]
		 @users=User.all
	end

	def update
			@team = Team.find_by_id params[:id]
			if @team.update team_params
				redirect_to team_path(@team)
			else
				render :edit
			end
	end


	private

	# def find_team
  #
	# end

	def get_categories
		@team_categories = TeamCategory.all
	end

	def get_users
		@users = User.where(:user_category_id => 2..3)
		@team_lead_id = UserCategory.where(name: 'Team Lead')
		@lead_users = User.where(user_category: @team_lead_id)
	end

	def team_params
		params.require(:team).permit(:name, :team_category_id, :team_lead_id, :user_id, {member_ids:[]})
	end

	def authorize_user!
		if current_user
			if current_user.user_category.name === 'Guest'
				flash[:notice] = 'Access denied.'
				redirect_to root_path
			end
		else
			flash[:alert] = 'Please sign in first.'
			redirect_to new_session_path
		end
	end



end
