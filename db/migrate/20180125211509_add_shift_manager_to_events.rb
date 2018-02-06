class AddShiftManagerToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :shift_manager_id, :integer
  end
end
