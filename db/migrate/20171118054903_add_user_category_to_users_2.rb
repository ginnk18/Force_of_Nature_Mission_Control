class AddUserCategoryToUsers2 < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :user_id
    add_reference :users, :user_category, foreign_key: true
  end
end
