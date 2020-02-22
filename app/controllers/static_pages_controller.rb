class StaticPagesController < ApplicationController
  before_action :set_auth
  before_action :authenticate_user!, only: [:adminpage]
  before_action :authenticate_admin!, only: [:adminpage]

  def home
    @hotels = Hotel.all
  end  

  def adminpage
  end

  private
  def set_auth
    @auth = session[:omniauth] if session[:omniauth]
  end

end
