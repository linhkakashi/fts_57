class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @subjects = Subject.all
      @exam = Exam.new
      @exams = current_user.exams.order(created_at: :desc).page(params[:page])
        .per Settings.PAGE_SIZE
    end
  end
end
