class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :user_id, null: false
      t.boolean :private, default: true, null: false 
      t.timestamps
    end
  end
end
