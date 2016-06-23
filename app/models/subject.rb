class Subject < ActiveRecord::Base
  has_many :questions
  has_many :exams

  validates :name, presence: true, length: {maximum: 45}
end
