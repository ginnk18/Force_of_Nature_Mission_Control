class EventCategory < ApplicationRecord
  has_many :events
  #Event categories will be: Canvass, Phonebank, Meeting, Slideshow, Research(?), Other
end
