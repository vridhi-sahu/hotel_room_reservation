class ConfirmMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.confirm_mailer.confirm_email.subject
  #
  def confirm_email(user, booking)
    @greeting = "Hi"
    @booking = booking
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "Confirmaion Email")
  end
end
