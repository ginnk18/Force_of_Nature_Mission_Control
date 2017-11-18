class AddGoogleEventIdToEvents < ActiveRecord::Migration[5.1]
  def change
  	add_column :events, :google_event_id, :integer, unique: true
  end
end
