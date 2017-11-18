class Event < ApplicationRecord

	#An event will only ever be one type - a canvas, a phonebank, etc
	belongs_to :event_category

	#An event has many users (guests), but a user can also belong to many events
	has_many :user_events, dependent: :destroy
	has_many :guests, through: :user_events, source: :user
end