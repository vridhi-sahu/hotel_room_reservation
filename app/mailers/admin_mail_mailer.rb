class AdminMailMailer < ApplicationMailer

  def admin_email(admin, user, booking)
    @greeting = "Hi"
    @booking  = booking
    @admin    = admin
    @user     = user
    @url      = 'http://example.com/login'
    mail(to: @admin.pluck(:email), subject: "Notification of Booking")
  end
end
