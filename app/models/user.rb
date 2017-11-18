class User < ApplicationRecord
	has_secure_password

	#A user can create many (has many) events, and also can belong to many events
	#through the 'user_events' table
	has_many :user_events, dependent: :destroy
	has_many :attended_events, through: :user_events, source: :event

	#The user categories keeps track of which type of user the current user is
	#Users can be general volunteers, team leads or admins
	belongs_to :user_category

	#A user will usually just belong to one team (most general vols will belong to 1
	# regional team - but some users (team leads) can belong to a regional team and an
	#operational team)
	has_many :user_teams, dependent: :destroy
	has_many :teams, through: :user_teams

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

	def full_name
		"#{first_name} #{last_name}"
	end

	# def approved
	# 	if user.approved
	# 		# must find a way to validate presence of first name and last name once
			#guest user gets approval to become a general volunteer
	# 	else
	# 	end
	# end

end
