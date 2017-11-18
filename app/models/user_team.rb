class UserTeam < ApplicationRecord
  belongs_to :user
  belongs_to :team
  #holds the many to many associations between users and teams
  #(most general volunteer users will belong to one regional team
  #but some team leads may also belong to operational teams)
end
