class SendEmailWorker
  include Sidekiq::Worker

  def perform exam_id
    ResultMailer.send_result_exam(exam_id).deliver_now
  end
end
