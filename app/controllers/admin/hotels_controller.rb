class Admin::HotelsController < Admin::BaseController
  before_action :find_hotel, only: [:edit, :update, :destroy, :show]

  def new
    @hotel  = Hotel.new
    prior_data
  end

  def index
    @hotels = Hotel.all
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      redirect_to admin_hotel_path(@hotel)
    else
      prior_data
      render :new, flash: { error: "Invalid data entry" }
    end
  end

  def update
    if @hotel.update_attributes(hotel_params)
      redirect_to admin_hotel_path
    else
      prior_data
      render :edit, flash: { error: "Validation error" }
    end
  end

  def edit
    prior_data
  end

  def destroy
    @hotel.destroy
    redirect_to(action: "index")
  end

  private

  def hotel_params
    params.require(:hotel).permit(:name, :city_id, :picture, :address, :single_bedroom_price, :double_bedroom_price, :suite_room_price, :dormitory_room_price, :single_bedroom_num, :double_bedroom_num, :suite_room_num, :dormitory_room_num)
  end

  def find_hotel
    @hotel = Hotel.find(params[:id])
  end

  def prior_data
    @cities = City.all
  end

end
