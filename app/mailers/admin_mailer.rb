class AdminMailer < ApplicationMailer
  default from: 'CM Library <mecklenburglibrary@gmail.com>'
   
    def notify_admin_email
      @admin = User.where(is_admin: true).last
      mail(to: @admin.email, subject: 'Welcome to My Awesome Site')
    end
end
