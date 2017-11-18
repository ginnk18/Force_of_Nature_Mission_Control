class Team < ApplicationRecord
	belongs_to :team_category

	# Teams can have many users (members), but users can belong to many
	# teams (most users will belong to one team but have the option to belong 
	#to 2 teams - a regional team and an operational team)
	has_many :user_teams, dependent: :destroy
	has_many :members, through: :user_teams, source: :user
end
