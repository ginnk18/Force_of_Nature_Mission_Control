class SeparatePredictedandActualTargets < ActiveRecord::Migration[5.1]
  def change
  	rename_column :events, :sign_ups, :sign_up_goals
  	rename_column :events, :show_ups, :show_up_goals
  	rename_column :events, :signatures, :signature_goals
  	add_column :events, :sign_up_outcome, :integer
    add_column :events, :show_up_outcome, :integer
    add_column :events, :signature_outcome, :integer
  end
end
