class ConfirmMailer < ApplicationMailer

  def approved_email(user, booking)
    @greeting = "Hi"
    @booking = booking
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "APPROVED BOOKING")
  end

  def rejected_email(user, booking)
    @greeting = "Hi"
    @booking = booking
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "REJECTED BOOKING")
  end

def inform_email(user, booking)
    @greeting = "Hi"
    @booking = booking
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "WAITING FOR CONFIRMATION")
  end



end
