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

    if not params[:subject_id].blank? and params[:subject_id].count > 0
      @problems = @problems.where(:subject_id => params[:subject_id])
    end

    if not params[:status_id].blank? and params[:status_id].count > 0
      @problems = @problems.where(:status_id => params[:status_id])
    end

    unless params[:rating_from].blank?
      @problems = @problems.where("rating >= ?", params[:rating_from].to_i)
    end
    unless params[:rating_to].blank?
      @problems = @problems.where("rating <= ?", params[:rating_to].to_i)
    end

    unless params[:distance_from].blank?
      @problems = @problems.where("distance >= ?", params[:distance_from].to_f * 1000)
    end
    unless params[:distance_to].blank?
      @problems = @problems.where("distance <= ?", params[:distance_to].to_f * 1000)
    end

    unless params[:distance_car_from].blank?
      @problems = @problems.where("distance_car >= ?", params[:distance_car_from].to_f * 1000)
    end
    unless params[:distance_car_to].blank?
      @problems = @problems.where("distance_car <= ?", params[:distance_car_to].to_f * 1000)
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
    params.require(:problem).permit(:subject_id, :status_id, :rating, :phone, :description, :title, :person, :address, :address_longitude, :address_latitude, :distance, :distance_car, :link, :email, :vk).delete_if {|k,v| v.blank?}
  end
end
