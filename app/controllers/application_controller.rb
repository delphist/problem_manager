class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate_user!, :highlighted_tasks

  def highlighted_tasks
    @highlighted_tasks = Task.where(:executor => current_user).where(:completed => false, :completed_request => false).count + Task.where(:director => current_user).where(:completed => false, :completed_request => true).count
  end
end
