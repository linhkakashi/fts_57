class QuestionsController < ApplicationController
  before_action :logged_in_user

  def new
    @subjects = Subject.all
    @question = Question.new
    @question.answers.build
  end

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = t "notice.create_question_success"
      redirect_to root_path
    else
      @subjects = Subject.all
      render :new
    end
  end

  private
  def question_params
    question = params[:question]
    question[:answers_attributes].delete_if do |key, value|
      (key != Settings.KEY_TEXT && question[:question_type] == Settings.TEXT) ||
        (key == Settings.KEY_TEXT && question[:question_type] != Settings.TEXT)
    end

    params[:question][:state] = Settings.WAITING
    params[:question][:user_id] = current_user.id

    params.require(:question).permit :content, :state, :question_type, :user_id,
      :subject_id, :state, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
