class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.date :date
      t.string :location
      t.text :additional_info
      t.string :attachment_url

      t.timestamps
    end
  end
end
