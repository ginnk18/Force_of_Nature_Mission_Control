class AddUserCategoryToUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :category
    add_reference :users, :user, foreign_key: true
  end
end
