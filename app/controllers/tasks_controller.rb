class TasksController < ApplicationController
  load_and_authorize_resource except: [:directioning, :executing]

  def index
    if Task.where(:executor => current_user).count > 0
      redirect_to tasks_executing_path
    else
      redirect_to tasks_directioning_path
    end
  end

  def directioning
    @tasks = Task.where(:director => current_user).order("deadline_at DESC").page(params[:page]).per(20)
  end

  def executing
    @tasks = Task.where(:executor => current_user).order("deadline_at DESC").page(params[:page]).per(20)
  end

  def create
    @task.director = current_user

    if @task.save
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def update
    @task.attributes = task_params

    if @task.save
      redirect_to tasks_path
    else
      render "edit"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  def accept
    @task = Task.find params[:task_id]
    @task.accept!
    redirect_to task_path(@task)
  end

  def decline
    @task = Task.find params[:task_id]
    @task.decline!
    redirect_to task_path(@task)
  end

  def complete
    @task = Task.find params[:task_id]
    @task.complete!
    redirect_to task_path(@task)
  end

  def cancel
    @task = Task.find params[:task_id]
    @task.cancel!
    redirect_to task_path(@task)
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :executor_id, :director_id, :problem_id, :deadline_at)
    end
end
