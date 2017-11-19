class UserCategory < ApplicationRecord
	has_many :users, dependent: :nullify
	#User categories will be: general volunteer, team lead, admin (and guest for unapproved users
	#who signed up for at least one event?)
end
