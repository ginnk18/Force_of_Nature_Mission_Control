class AddSubjectsToEmails < ActiveRecord::Migration[5.1]
  def change
    add_column :custom_emails, :subject, :string
    add_column :custom_emails, :sender, :string
  end
end
