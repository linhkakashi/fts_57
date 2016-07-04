class ExamsController < ApplicationController
  before_action :logged_in_user
  before_action :load_exam, only: [:show]
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

  def show
    if @exam.start?
      @time_start = Time.now.to_i
      @exam.update_attributes time_start: @time_start, status: :testing
    else
      @exam_questions = @exam.exam_questions
      @time_start = @exam.time_start
    end
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

  def load_exam
    @exam = Exam.find_by id: params[:id]
  end
end
