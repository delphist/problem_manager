class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.integer :subject_id
      t.string :person
      t.text :address
      t.float :address_longitude
      t.float :address_latitude
      t.text :description
      t.string :link
      t.integer :status_id
      t.integer :rating
      t.string :phone
      t.string :email
      t.string :vk

      t.index :subject_id
      t.index :status_id

      t.timestamps
    end
  end
end
