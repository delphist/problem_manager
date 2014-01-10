class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
  end

  def edit
    @subject = Subject.find params[:id]
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.valid?
      @subject.save
      redirect_to subjects_path
    else
      render "new"
    end
  end

  def update
    @subject = Subject.find params[:id]
    @subject.attributes = subject_params

    if @subject.valid?
      @subject.save
      redirect_to subjects_path
    else
      render "edit"
    end
  end

  def destroy
    @subject = Subject.find params[:id]
    @subject.destroy
    redirect_to subjects_path
  end

  def subject_params
    params.require(:subject).permit(:title).delete_if {|k,v| v.blank?}
  end
end
