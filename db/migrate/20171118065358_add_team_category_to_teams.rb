class AddTeamCategoryToTeams < ActiveRecord::Migration[5.1]
  def change
    add_reference :teams, :team_category, foreign_key: true, index: true
  end
end
