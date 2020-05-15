class SearchHotelsController < ApplicationController

  before_action :set_auth

  def show
    guests    = params[:num_of_guests].to_i
    city      = params[:city]
    @hotels   = Hotel.all
    @hotels   = @hotels.select{ |hotel| hotel if (hotel.single_bedroom_num >= guests || hotel.double_bedroom_num >= guests || hotel.suite_room_num >= guests || hotel.dormitory_room_num >= guests) and hotel.city_id ==  city.to_i }
  end

private
  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end
end
