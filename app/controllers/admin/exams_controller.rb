class Admin::ExamsController < ApplicationController
  before_action :logged_in_user, only: [:index, :update]
  load_and_authorize_resource

  def index
    @exams = Exam.order(created_at: :desc).page(params[:page])
      .per Settings.PAGE_SIZE
  end

  def show
    @exam_questions = @exam.exam_questions
    @current_score = @exam.caculate_score
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t "exam.save_question"
    else
      flash[:danger] =  t "exam.save_question_failed"
    end
    SendEmailWorker.perform_async @exam.id
    redirect_to admin_exams_path
  end

  private
  def exam_params
    params[:exam][:score] = @exam.caculate_score  if params[:exam][:score].empty?
    params[:exam][:status] = Settings.STATUS_CHECKED
    params.require(:exam).permit :status, :score
  end
end
