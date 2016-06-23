class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :answers
  has_many :exam_questions

  validates :content, presence: true, length: {maximum: 120}
end
