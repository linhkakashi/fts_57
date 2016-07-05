class ExamMailer < ApplicationMailer
  def send_static_exam user_id
    @user = User.find_by id: user_id
    @exams = Exam.statistic_exam user_id, Date.today
    mail to: @user.email, subject: t("email.static_exam")
  end
end
