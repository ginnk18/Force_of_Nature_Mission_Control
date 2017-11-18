class Team < ApplicationRecord
	belongs_to :team_category

	# Teams can have many users, but users can belong to many teams (mostly will belong to one
	#but with the option to belong to 2 teams - a regional team and an operational team)
	has_many :user_teams, dependent: :destroy
	has_many :users, through: :user_teams
end
