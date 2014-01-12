class UserMailer < ActionMailer::Base
  default from: "noreply@spravedlivielydi.ru"

  def mention_email(to_user, from_user, comment)
    @to_user = to_user
    @from_user = from_user
    @comment = comment
    mail to: @to_user.email, subject: "#{@from_user.name} упомянул вас"
  end

  def deadline_warning_email(task)
    @task = task
    mail to: @task.executor.email, subject: "Срок задачи истекает через #{@task.deadline_days.to_s} " + Russian.pluralize(@task.deadline_days, "день", "дня", "дней")
  end

  def deadline_expired_email(task)
    @task = task

    @deadline_expired = "сегодня"
    if @task.deadline_days < 0
      @deadline_expired = (@task.deadline_days * -1).to_s + Russian.pluralize(@task.deadline_days * -1, "день", "дня", "дней") + " назад"
    end

    mail to: @task.executor.email, subject: "Срок задачи истек #{@deadline_expired}"
  end

  def new_task_email(task)
    @task = task

    mail to: @task.executor.email, subject: "Вам посталена новая задача"
  end

  def task_completed_email(task)
    @task = task

    mail to: @task.director.email, subject: "Поставленная вами задача выполнена"
  end
end
