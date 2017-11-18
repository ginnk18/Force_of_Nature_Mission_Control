class CreateTeamCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :team_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
