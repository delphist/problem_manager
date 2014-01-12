class TasksController < ApplicationController
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

  def new
    @task = Task.new
  end

  def show
    @task = Task.find params[:id]
  end

  def edit
    @task = Task.find params[:id]
  end

  def create
    @task = Task.new(task_params)
    @task.director = current_user

    if @task.save
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def update
    @task = Task.where(:director => current_user).find params[:id]
    @task.attributes = task_params

    if @task.save
      redirect_to tasks_path
    else
      render "edit"
    end
  end

  def destroy
    @task = Task.find params[:id]
    @task.destroy
    redirect_to tasks_path
  end

  private

    def task_params
      params.require(:task).permit(:title, :description, :executor_id, :director_id, :problem_id, :deadline_at)
    end
end
