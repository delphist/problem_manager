class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :problem_id
      t.text :body

      t.index :problem_id

      t.timestamps
    end
  end
end
