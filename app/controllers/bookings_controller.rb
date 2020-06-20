class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:client_bookings, :update_status]
  before_action :get_booking, only: [:update_status, :destroy]
  def index
    bookings = []
    reservations = current_user.admin? ? Booking.all : Booking.where(user_id: current_user.id)
    reservations.each do |booking|
      bookings << {id: booking.id, title: "#{booking.guest_name}  #{!booking.approved? ? 'event is '+booking.status.titleize : ''  }", start: booking.check_in_date, end: booking.check_out_date + 1.day} if booking.check_in_date.present?
    end
    gon.bookings = bookings
  end

  def new
    @booking = Booking.new
    session[:hotel_id] = params[:hotel_id]
    @hotel     = current_hotel
    @single    = @hotel.single_bedroom_num.to_i
    @double    = @hotel.double_bedroom_num.to_i
    @suite     = @hotel.suite_room_num.to_i
    @dormitory = @hotel.dormitory_room_num.to_i
  end

  def create
    authorize unless signed_in?
    @booking  = current_hotel.bookings.build(book_params)
    @booking.user_id = current_user.id
    if @booking.save
      ConfirmMailer.inform_email(current_user, @booking).deliver
      AdminMailMailer.admin_email(User.admin, current_user, @booking).deliver
      alter_rooms(current_hotel)
      redirect_to bookings_path, flash: { success: "Booked successfully!" }
    else
      flash.now[:error] = "Couldn't make the booking."
    end
  end

  def client_bookings
    @bookings = Booking.all
  end

  def update_status
    @booking.update(status: params[:status])
    if @booking.rejected?
      rewise_room_hotel(@booking)
      ConfirmMailer.rejected_email(current_user, @booking).deliver
    elsif @booking.approved?
      ConfirmMailer.approved_email(current_user, @booking).deliver
    end
    redirect_to(action: :client_bookings)
  end


  def destroy
    rewise_room_hotel(@booking)
    @booking.destroy
    redirect_to(action: :client_bookings)
  end

  private

  def book_params
    params.require(:booking).permit(:id, :num_of_guests, :guest_name, :check_in_date, :check_out_date, :single_bedroom_num, :double_bedroom_num, :suite_room_num, :dormitory_room_num, :user_id)
  end
  def current_hotel
    @current_hotel ||= Hotel.find(session[:hotel_id])
  end

  def alter_rooms(hotel)
    @booking.alter_rooms_booked(hotel)
    @booking.total_price_of_booking(hotel)
  end

  def get_booking
    @booking = Booking.find(params[:id])
  end

  def rewise_room_hotel(booking)
    hotel = booking.hotel
    hotel.single_bedroom_num += booking.single_bedroom_num
    hotel.double_bedroom_num += booking.double_bedroom_num
    hotel.suite_room_num     += booking.suite_room_num
    hotel.dormitory_room_num += booking.dormitory_room_num
    hotel.save
  end

  # def set_null_booking(booking)
  #   booking.udpate(single_bedroom_num: 0,double_bedroom_num: 0,suite_room_num: 0,dormitory_room_num: 0)
  # end


end