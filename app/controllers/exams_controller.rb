class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = Subject.all
    @exam = Exam.new
    @exams = current_user.exams.order(created_at: :desc).page(params[:page])
      .per Settings.PAGE_SIZE
  end

  def create
    @exam = current_user.exams.build exam_params
    if @exam.save
      flash[:success] = t "exam.create_exam_success"
    else
      flash[:danger] = t "exam.create_exam_failed"
    end
    redirect_to exams_path
  end

  private
  def exam_params
    @subject = Subject.find params[:exam][:subject_id]
    params[:exam][:duration] = if @subject.id % 2 == 0
      Settings.WITH_10_MINUTES
    else
      Settings.WITH_20_MINUTES
    end
    params.require(:exam).permit :subject_id, :duration, :status
  end
end
