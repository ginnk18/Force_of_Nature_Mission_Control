class AddContactedToUsers < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :contacted, :boolean, default: false
  end
end
