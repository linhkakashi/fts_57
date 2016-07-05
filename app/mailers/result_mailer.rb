class ResultMailer < ApplicationMailer
  def send_result_exam exam_id
    @exam = Exam.find_by id: exam_id
    mail to: @exam.user.email, subject: t("email.result_exam")
  end
end
