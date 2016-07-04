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
    add_duration_to_exam
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

  def update
    @exam.time_end = Time.now.to_i
    @exam.status = :unchecked if params[:commit] == Settings.FINISH
    if @exam.update_attributes exam_params
      flash[:success] = t "exam.save_question"
    else
      flash[:danger] =  t "exam.save_question_failed"
    end
    redirect_to exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :subject_id, :duration, :status,
      exam_questions_attributes: [:id, :answer_id]
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
  end

  def add_duration_to_exam
    @subject = Subject.find params[:exam][:subject_id]
    params[:exam][:duration] = if @subject.id % 2 == 0
      Settings.WITH_10_MINUTES
    else
      Settings.WITH_20_MINUTES
    end
  end
end
