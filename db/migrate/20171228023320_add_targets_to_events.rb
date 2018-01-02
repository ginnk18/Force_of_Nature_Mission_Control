class AddTargetsToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :sign_ups, :integer
    add_column :events, :show_ups, :integer
    add_column :events, :signatures, :integer
  end
end
