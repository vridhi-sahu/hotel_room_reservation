class AdminMailMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mail_mailer.admin_email.subject
  #
  def admin_email(admin, user, booking)
    @greeting = "Hi"
    @booking = booking
    @admin = admin
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @admin.pluck(:email), subject: "Notification of Booking")
  end
end
