class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  #holds the many to many associations between users and events 
  validates :event_id, uniqueness: { scope: :user_id }
end
