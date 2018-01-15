class AddCanvasCaptainToEvents < ActiveRecord::Migration[5.1]
  def change
  	add_column :events, :canvas_captain_id, :integer
  end
end
