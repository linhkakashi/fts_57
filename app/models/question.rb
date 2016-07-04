class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :answers
  has_many :exam_questions

  validates :content, presence: true, length: {maximum: 120}

  enum question_type: [:single_choice, :multiple_choice, :text]
  enum state: [:accept, :waiting, :reject]

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: lambda{|answer| answer[:content].blank?}

  scope :contributed_by, ->user{where(user_id: user.id).order created_at: :desc}
  scope :accepted, -> {where state: :accept}
end
