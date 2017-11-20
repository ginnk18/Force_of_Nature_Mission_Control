class AddTeamIdToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :team, foreign_key: true
  end
end
