class Team < ApplicationRecord
	belongs_to :team_category

	belongs_to :team_lead, class_name: "User"

	# Teams can have many users (members), but users can belong to many
	# teams (most users will belong to one team but have the option to belong 
	#to 2 teams - a regional team and an operational team)
	has_many :user_teams, dependent: :destroy
	has_many :members, through: :user_teams, source: :user
	
	#A team is associated with many events
	has_many :events, dependent: :nullify
end
