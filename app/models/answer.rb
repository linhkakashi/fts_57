class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :exam_questions

  validates :content, presence: true, length: {maximum: 120}
end
