class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authenticate_user!, :highlighted_tasks

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def highlighted_tasks
    @highlighted_tasks = Task.where(:executor => current_user).where(:completed => false, :completed_request => false).count + Task.where(:director => current_user).where(:completed => false, :completed_request => true).count if user_signed_in?
  end
end
