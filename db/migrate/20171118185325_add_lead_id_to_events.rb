class AddLeadIdToEvents < ActiveRecord::Migration[5.1]
  def change
  	add_reference :events, :lead, references: :users
  end
end
