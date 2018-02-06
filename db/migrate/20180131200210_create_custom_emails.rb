class CreateCustomEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_emails do |t|
      t.string :to_recipients
      t.text :email_body 

      t.timestamps
    end
  end
end
