class SubjectsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = Subject.page(params[:page]).per(40)
  end

  def show
    redirect_to edit_subject_path(@subject)
  end

  def create
    @subject.attributes = subject_params

    if @subject.valid?
      @subject.save
      redirect_to subjects_path
    else
      render "new"
    end
  end

  def update
    @subject.attributes = subject_params

    if @subject.valid?
      @subject.save
      redirect_to subjects_path
    else
      render "edit"
    end
  end

  def destroy
    @subject.destroy
    redirect_to subjects_path
  end

  private

    def subject_params
      params.require(:subject).permit(:title, :parent_id)
    end
end
