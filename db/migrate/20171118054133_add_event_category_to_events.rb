class AddEventCategoryToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :event_category, foreign_key: true, index: true
  end
end
