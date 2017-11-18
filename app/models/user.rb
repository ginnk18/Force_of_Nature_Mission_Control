class User < ApplicationRecord
	has_secure_password
	has_many :user_events, dependent: :destroy
	has_many :events, through: :user_events
	belongs_to :user_category

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

	def full_name
		"#{first_name} #{last_name}"
	end

	# def approved
	# 	if user.approved
	# 		errors.add()
	# 	else
	# 	end
	# end

end
