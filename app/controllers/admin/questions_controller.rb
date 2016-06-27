class Admin::QuestionsController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create]
  load_and_authorize_resource

  def index
    @questions = Question.order(created_at: :desc).page(params[:page])
      .per Settings.PAGE_SIZE
  end

  def new
    @subjects = Subject.all
    @question = Question.new
    @question.answers.build
  end

  def create
    @subjects = Subject.all
    @question = Question.new question_params
    if @question.save
      flash[:success] = t "notice.create_question_success"
      redirect_to admin_questions_path
    else
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

    params[:question][:state] = Settings.ACCEPT

    params.require(:question).permit :content, :state, :question_type, :user_id,
      :subject_id, :state, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
