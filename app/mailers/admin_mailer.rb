class AdminMailer < ApplicationMailer
  default from: 'notifications@cm.com'
   
    def notify_admin_email
      @admin = User.where(is_admin: true).last
      mail(to: @admin.email, subject: 'Welcome to My Awesome Site')
    end
end
