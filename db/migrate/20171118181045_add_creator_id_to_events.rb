class AddCreatorIdToEvents < ActiveRecord::Migration[5.1]
  def change
  	add_reference :events, :creator, references: :users
  end
end
