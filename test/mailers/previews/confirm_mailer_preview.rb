# Preview all emails at http://localhost:3000/rails/mailers/confirm_mailer
class ConfirmMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/confirm_mailer/confirm_email
  def confirm_email
    ConfirmMailer.confirm_email
  end

end
