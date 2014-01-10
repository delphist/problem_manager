class AddPhoneToProblems < ActiveRecord::Migration
  def change
    rename_column :problems, :comment, :title
  end
end
