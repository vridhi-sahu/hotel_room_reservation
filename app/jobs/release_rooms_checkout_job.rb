class ReleaseRoomsCheckoutJob < ApplicationJob
  queue_as :default

  def perform(h_id, booking)
    # Do something later
    @single = Room.joins(:hotel).where("hotel_id = ?", h_id).pluck(:single_bedroom_num)
    s = @single[0].to_i
    @double = Room.joins(:hotel).where("hotel_id = ?", h_id).pluck(:double_bedroom_num)
    d = @double[0].to_i
    @suite = Room.joins(:hotel).where("hotel_id = ?", h_id).pluck(:suite_room_num)
    sui = @suite[0].to_i
    @dormitory = Room.joins(:hotel).where("hotel_id = ?", h_id).pluck(:dormitory_room_num)
    dor = @dormitory[0].to_i

    @so = booking.single_bedroom_num
    s_new = @so.to_i
    @duo = booking.double_bedroom_num
    d_new = @duo.to_i
    @suio = booking.suite_room_num
    sui_new = @suio.to_i
    @doro = booking.dormitory_room_num
    dor_new = @doro.to_i

    s_res = (s + s_new)
    d_res = (d + d_new)
    sui_res = (sui + sui_new)
    dor_res = (dor + dor_new)
    @room = Room.find_by(hotel_id: h_id)
    @room.update_attributes(single_bedroom_num: s_res, double_bedroom_num: d_res, suite_room_num: sui_res, dormitory_room_num: dor_res )
  end
end
