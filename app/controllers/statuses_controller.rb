class StatusesController < ApplicationController
  load_and_authorize_resource

  def index
    @statuses = Status.page(params[:page]).per(40)
  end

  def show
    redirect_to edit_status_path(@status)
  end


  def create
    @status.attributes = status_params

    if @status.save
      redirect_to statuses_path
    else
      render "new"
    end
  end

  def update
    @status.attributes = status_params

    if @status.save
      redirect_to statuses_path
    else
      render "edit"
    end
  end

  def destroy
    @status.destroy
    redirect_to statuses_path
  end

  private

    def status_params
      params.require(:status).permit(:title, :map_color)
    end
end
