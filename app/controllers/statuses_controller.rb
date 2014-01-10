class StatusesController < ApplicationController
  def index
    @statuses = Status.page(params[:page]).per(40)
  end

  def new
    @status = Status.new
  end

  def edit
    @status = Status.find params[:id]
  end

  def create
    @status = Status.new(status_params)

    if @status.valid?
      @status.save
      redirect_to statuses_path
    else
      render "new"
    end
  end

  def update
    @status = Status.find params[:id]
    @status.attributes = status_params

    if @status.valid?
      @status.save
      redirect_to statuses_path
    else
      render "edit"
    end
  end

  def destroy
    @status = Status.find params[:id]
    @status.destroy
    redirect_to statuses_path
  end

  def status_params
    params.require(:status).permit(:title, :map_color).delete_if {|k,v| v.blank?}
  end
end
