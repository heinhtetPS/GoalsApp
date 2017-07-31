class AddCompletedtoGoals < ActiveRecord::Migration
  def change
    add_column :goals, :completed, :boolean, default: false, null: false 
  end
end
