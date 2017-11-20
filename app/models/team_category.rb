class TeamCategory < ApplicationRecord
	has_many :teams, dependent: :nullify
	#Team categories will just be 'Regional Teams' and 'Operational Teams'
	#Regional - the riding/region the team works in and holds events in
	#Operational - canvass team, phonebank team, leadership team, etc...
end
