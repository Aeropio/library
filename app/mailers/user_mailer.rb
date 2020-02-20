class UserMailer < ApplicationMailer
  default from: 'notifications@cm.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sign_up_notification.subject
  #
  def sign_up_notification
    # @greeting = "Hi"

    # mail to: "to@example.org"
    # @admin = User.where(is_admin: true).last
    @user = params[:user]
    mail(to: @user.email, subject: 'Sign Up successfull')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.approved_notification.subject
  #
  def approved_notification
    @user = params[:user]
    mail(to: @user.email, subject: 'Library Card Request Approved')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.rejected_notification.subject
  #
  def rejected_notification
    @user = params[:user]
    mail(to: @user.email, subject: 'Library Card Request Rejected')
  end
end
