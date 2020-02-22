# Preview all emails at http://localhost:3000/rails/mailers/admin_mail_mailer
class AdminMailMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin_mail_mailer/admin_email
  def admin_email
    AdminMailMailer.admin_email
  end

end
