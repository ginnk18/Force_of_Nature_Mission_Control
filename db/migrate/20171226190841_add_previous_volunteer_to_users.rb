class AddPreviousVolunteerToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :previous_volunteer, :boolean, default: false
  end
end
