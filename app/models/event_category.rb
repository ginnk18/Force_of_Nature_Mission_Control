class EventCategory < ApplicationRecord
  has_many :events, dependent: :nullify
  #Event categories will be: Canvass, Phonebank, Meeting, Slideshow, Research(?), Other
end
