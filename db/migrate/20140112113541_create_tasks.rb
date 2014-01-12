class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :director_id, index: true, null: false
      t.integer :executor_id, index: true, null: false
      t.integer :problem_id, index: true, null: true
      t.string :title
      t.text :description
      t.boolean :completed, index: true, null: false, default: false
      t.boolean :completed_request, null: false, default: false

      t.timestamp :completed_at
      t.timestamp :deadline_at, index: true, null: false

      t.timestamps
    end
  end
end
