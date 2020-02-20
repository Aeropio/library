# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/sign_up_notification
  def sign_up_notification
    UserMailer.sign_up_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/approved_notification
  def approved_notification
    UserMailer.approved_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/rejected_notification
  def rejected_notification
    UserMailer.rejected_notification
  end

end
