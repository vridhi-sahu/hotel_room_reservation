class BookingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @booking = Booking.new
    session[:hotel_id] = params[:hotel_id]
    @hotel = current_hotel
    @single = @hotel.single_bedroom_num.to_i
    @double = @hotel.double_bedroom_num.to_i
    @suite = @hotel.suite_room_num.to_i
    @dormitory = @hotel.dormitory_room_num.to_i
  end

  def create
    authorize unless signed_in?
    @hotel    = current_hotel
    @booking  = @hotel.bookings.build(book_params)
    @booking.user_id = current_user.id
    if @booking.save
      ConfirmMailer.confirm_email(current_user, @booking).deliver
      AdminMailMailer.admin_email(User.admin, current_user, @booking).deliver
      alter_rooms(@hotel)
      redirect_to reservations_bookings_path, flash: { success: "booked successfully!" }
    else
      flash.now[:error] = "Couldn't make the booking."
    end
  end

  def reservations
    bookings = []
    Booking.all.each do |booking|
      bookings << {id: booking.id, title: booking.guest_name, start: booking.check_in_date, end: booking.check_out_date} if booking.check_in_date.present?
    end
    gon.bookings = bookings
  end


  private

  def book_params
    params.require(:booking).permit(:id, :num_of_guests, :guest_name, :check_in_date, :check_out_date, :single_bedroom_num, :double_bedroom_num, :suite_room_num, :dormitory_room_num, :hotel_name, :hotel_id, :user_id)
  end
  def current_hotel
    @current_hotel ||= Hotel.find(session[:hotel_id])
  end

  def alter_rooms(hotel)
    @booking.alter_rooms_booked(hotel)
    @booking.total_price_of_booking(hotel)
  end

end