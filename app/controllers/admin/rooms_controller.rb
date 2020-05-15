class Admin::RoomsController < Admin::BaseController
  before_action :find_room, only: [:edit, :update, :destroy, :show]
  def new
    @hotel = Hotel.new
  end

  def index
    @rooms = Hotel.all
  end

  def show
    @room = Hotel.find(params[:id])
  end

  def update
    if @room.update_attributes(room_params)
      redirect_to room_path(@room)
    else
      render :edit, flash: { error: "Validation error" }
    end
  end

  private
  def room_params
    params.require(:hotel).permit(:id ,:single_bedroom_num, :double_bedroom_num, :suite_room_num, :dormitory_room_num )
  end

  def find_room
    @room = Hotel.find(params[:id])
  end
end
