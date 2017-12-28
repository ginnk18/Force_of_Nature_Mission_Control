class AddUserToEvents < ActiveRecord::Migration[5.1]
  def change
    # add_reference :events, :user, foreign_key: true
    add_column :events, :data_captain_id, :integer
  end
end
