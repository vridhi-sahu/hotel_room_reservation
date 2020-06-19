class StaticPagesController < ApplicationController
  before_action :set_auth
  before_action :authenticate_user! => nil, only: [:adminpage]
  before_action :authenticate_admin!, only: [:adminpage]

  def home
    @hotels = Hotel.all
    @search = if params[:search].present?
      JSON.parse(params[:search].to_s.gsub('=>', ':')).except!(["utf8", "commit", "controller", "action"])
    else
      {"num_of_guests" => nil, "num_of_rooms" => nil, "check_in_date" => nil, "check_out_date" => nil, "city"  => nil}
    end
  end

  def adminpage
  end

  private
  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end

end
