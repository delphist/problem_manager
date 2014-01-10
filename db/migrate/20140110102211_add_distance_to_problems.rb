class AddDistanceToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :distance, :float
    add_column :problems, :distance_car, :float
    add_column :problems, :comment, :text
  end
end
