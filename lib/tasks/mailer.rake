namespace :mailer do
  namespace :tasks do
    task :deadlines => :environment do
      Task.where(:completed => false, :completed_request => false).where("deadline_at > ?", Time.now() - 3.days).each do |task|
        if task.deadline_days > 0
          UserMailer.deadline_warning_email(task).deliver
        else
          UserMailer.deadline_expired_email(task).deliver
        end
      end
    end
  end
end