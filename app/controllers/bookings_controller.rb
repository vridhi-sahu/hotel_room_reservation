class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_hotel, except: [:new]
  after_action :alter_rooms, only: [:create]

  def new
    @booking = Booking.new
    session[:hotel_id] = params[:hotel_id]
    @hotel = current_hotel
    @single = Hotel.find(params[:hotel_id]).single_bedroom_num.to_i
    @double = Hotel.find(params[:hotel_id]).double_bedroom_num.to_i
    @suite = Hotel.find(params[:hotel_id]).suite_room_num.to_i
    @dormitory = Hotel.find(params[:hotel_id]).dormitory_room_num.to_i

    # these accessed in the views (booking/new.html.erb) hence not kept in models.
  end

  def index
  end

  def create
    @booking = @current_hotel.bookings.build(book_params)
    @user = current_user
    @admin = User.admin
    if signed_in?
      @booking.user_id = current_user.id
    else
      authorize 
    end
    
    if @booking.save
      ConfirmMailer.confirm_email(@user, @booking).deliver
      AdminMailMailer.admin_email(@admin, @user, @booking).deliver
      redirect_to root_path, flash: { success: "booked successfully!" }
    else
      flash.now[:error] = "Couldn't make the booking."
    end
  end
  
  def show
  end

  private

  def book_params
    params.require(:booking).permit(:id, :num_of_guests, :guest_name, :check_in_date, :check_out_date, :single_bedroom_num, :double_bedroom_num, :suite_room_num, :dormitory_room_num, :hotel_name, :hotel_id, :user_id)
  end
  def current_hotel
    @current_hotel ||= Hotel.find(session[:hotel_id])
  end
  
  def alter_rooms
    @booking.alter_rooms_booked(session[:hotel_id])
    @booking.total_price_of_booking
  end

end