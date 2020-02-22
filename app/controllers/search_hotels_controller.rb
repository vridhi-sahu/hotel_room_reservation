class SearchHotelsController < ApplicationController
  before_action :set_auth
  def show
    guests = params[:num_of_guests]
    guestsd= (params[:num_of_guests].to_i/2)
    guestsu= (params[:num_of_guests].to_i/3)
    guestsdor= (params[:num_of_guests].to_i/4)

    if params[:city] && params[:num_of_guests]
      @hotels = Hotel.where("single_bedroom_num >= ? OR double_bedroom_num >= ? OR suite_room_num >= ? OR dormitory_room_num >= ?", guests, guestsd, guestsu, guestsdor).where(city_id: params[:city])
    elsif params[:num_of_guests]
      @hotels = Hotel.where("single_bedroom_num >= ? OR double_bedroom_num >= ? OR suite_room_num >= ? OR dormitory_room_num >= ?", guests, guestsd, guestsu, guestsdor)
    elsif params[:city] 
      @hotels = Hotel.joins(:city).where(city_id: params[:city])
    else
      @hotels = Hotel.all
    end
    # this is a controller with no model and the params are fetched over here so the queries are written here.
  end

private
  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end
end
