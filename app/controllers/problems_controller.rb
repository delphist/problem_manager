class ProblemsController < ApplicationController
  def index
    params[:sort] ||= "created_at_desc"
    params[:view] ||= "table"

    @problems = Problem.scoped

    sort_field = params[:sort].split("_")[0..-2].join("_")
    sort_direction = params[:sort].split("_")[-1]

    if ["created_at", "rating", "distance", "distance_car"].include?(sort_field) and ["desc", "asc"].include?(sort_direction)
      @problems = Problem.order(sort_field + " " + sort_direction.upcase)
    end

    unless params[:subject_id].blank?
      subject = Subject.find params[:subject_id]
      @problems = @problems.where(:subject_id => subject.id)
    end

    unless params[:status_id].blank?
      status = Status.find params[:status_id]
      @problems = @problems.where(:status_id => status.id)
    end

    unless params[:rating].blank?
      @problems = @problems.where(:rating => params[:rating].to_i)
    end

    if params[:view].to_sym == :table
      @problems = @problems.page(params[:page]).per(40)
    end
  end

  def show
    @problem = Problem.find params[:id]
  end

  def new
    @problem = Problem.new
  end

  def edit
    @problem = Problem.find params[:id]
  end

  def create
    @problem = Problem.new(problem_params)

    if @problem.valid?
      @problem.save
      redirect_to problems_path
    else
      render "new"
    end
  end

  def update
    @problem = Problem.find params[:id]
    @problem.attributes = problem_params

    if @problem.valid?
      @problem.save
      redirect_to problems_path
    else
      render "edit"
    end
  end

  def destroy
    @problem = Problem.find params[:id]
    @problem.destroy
    redirect_to problems_path
  end

  def problem_params
    params.require(:problem).permit(:subject_id, :status_id, :rating, :description, :title, :person, :address, :address_longitude, :address_latitude, :distance, :distance_car, :link, :email, :vk).delete_if {|k,v| v.blank?}
  end
end
