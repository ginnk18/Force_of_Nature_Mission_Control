class Event < ApplicationRecord
	belongs_to :event_category
	has_many :user_events, dependent: :destroy
	has_many :users, through: :user_events
end
