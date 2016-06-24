class Admin::SubjectsController < ApplicationController
  before_action :load_subject, except: [:index, :new, :create]

  def index
    @subjects = Subject.order(created_at: :desc).page(params[:page])
      .per Settings.PAGE_SIZE
  end

  def show
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "notice.create_subject_success"
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "notice.update_subject_success"
      redirect_to admin_subject_path @subject
    else
      render :edit
    end
  end

  def destroy
    @subject.destroy
    flash[:success] = t "notice.deleted_subject_success"
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
  end
end
