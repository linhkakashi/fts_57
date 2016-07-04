class Exam < ActiveRecord::Base
  enum status: [:start, :testing, :unchecked, :checked]

  belongs_to :user
  belongs_to :subject
  has_many :exam_questions
  has_many :questions, through: :exam_questions

  before_create :create_questions
  before_validation :set_number_of_question
  validate :check_number_questions_in_subject

  private
  def create_questions
    self.questions = subject.questions.accepted.order("RANDOM()")
      .limit question_number
  end

  def set_number_of_question
    if subject.questions.size > 10
      self.question_number = 10
    else
      self.question_number = subject.questions.size
    end
  end

  def check_number_questions_in_subject
    @subject = Subject.find self.subject_id
    if @subject.questions.size < 1
      errors.add :exam, I18n.t("error.need_questions")
    end
  end
end
