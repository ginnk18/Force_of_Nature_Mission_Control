class AddTeamLeadToTeams < ActiveRecord::Migration[5.1]
  def change
  	add_reference :teams, :team_lead, references: :users
  end
end
