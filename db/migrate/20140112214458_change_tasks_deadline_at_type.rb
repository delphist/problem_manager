class ChangeTasksDeadlineAtType < ActiveRecord::Migration
  def change
    change_column :tasks, :deadline_at, :date
  end
end
