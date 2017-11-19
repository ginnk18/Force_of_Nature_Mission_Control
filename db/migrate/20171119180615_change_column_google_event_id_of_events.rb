class ChangeColumnGoogleEventIdOfEvents < ActiveRecord::Migration[5.1]
  def change
      change_column :events, :google_event_id, :string
  end
end
