class Booking < ApplicationRecord
  belongs_to :hotel
  belongs_to :user

  validate :check_out_greater_than_check_in
  validates :num_of_guests, :guest_name, :check_in_date, :check_out_date,  presence: true

  def check_out_greater_than_check_in
    
    if check_in_date.present? && check_in_date > check_out_date

      errors.add(:check_out_date, "Cant be lesser than check in!")
    end
  end

  def alter_rooms_booked(h_id)

    single = Hotel.find(h_id).single_bedroom_num.to_i
    double = Hotel.find(h_id).double_bedroom_num.to_i
    suite = Hotel.find(h_id).suite_room_num.to_i
    dormitory = Hotel.find(h_id).dormitory_room_num.to_i
    s_new = self.single_bedroom_num.to_i
    d_new = self.double_bedroom_num.to_i
    sui_new = self.suite_room_num.to_i
    dor_new = self.dormitory_room_num.to_i
    h_id = self.hotel_id.to_i
    s_res = (single - s_new)
    d_res = (double - d_new)
    sui_res = (suite - sui_new)
    dor_res = (dormitory - dor_new)
    @hotel = Hotel.find(h_id)
    @hotel.update_attributes(single_bedroom_num: s_res, double_bedroom_num: d_res, suite_room_num: sui_res, dormitory_room_num: dor_res )  
  end

  def total_price_of_booking

      single = single_bedroom_num.to_i
      double = double_bedroom_num.to_i
      suite = suite_room_num.to_i
      dormitory = dormitory_room_num.to_i
      single_price = hotel.single_bedroom_price.to_i
      double_price = hotel.double_bedroom_price.to_i
      suite_price = hotel.suite_room_price.to_i
      dormitory_price = hotel.dormitory_room_price.to_i
      total_price = (single * single_price) + (double * double_price) + (suite * suite_price) + (dormitory * dormitory_price)
      self.update_attributes(total: total_price)
  end
  
# Using cronjob to call release_rooms method every day at 11:30a.m (config/schedule.rb) in production evironment.
  def self.release_rooms

    all.each do |booking|

      if booking.check_out_date <= Date.today

        single = booking.hotel.single_bedroom_num.to_i
        double = booking.hotel.double_bedroom_num.to_i
        suite = booking.hotel.suite_room_num.to_i
        dormitory = booking.hotel.dormitory_room_num.to_i
        s_new = booking.single_bedroom_num.to_i
        d_new = booking.double_bedroom_num.to_i
        sui_new = booking.suite_room_num.to_i
        dor_new = booking.dormitory_room_num.to_i
        s_res = (single + s_new)
        d_res = (double + d_new)
        sui_res = (suite + sui_new)
        dor_res = (dormitory + dor_new)
        @hotel = booking.hotel
        @hotel.update_attributes(single_bedroom_num: s_res, double_bedroom_num: d_res, suite_room_num: sui_res, dormitory_room_num: dor_res )
      end
    end
  end

end
