class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :exam_questions
end
