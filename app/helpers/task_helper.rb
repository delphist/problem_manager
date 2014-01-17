module TaskHelper
  def task_row_color task
    if task.completed
      ""
    elsif task.deadline_days <= 0
      "danger"
    elsif task.deadline_days > 0
      "success"
    end
  end
end
