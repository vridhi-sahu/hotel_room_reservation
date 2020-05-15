class Hotel < ApplicationRecord
	has_many :bookings
	belongs_to :city

	geocoded_by :address
	after_validation :geocode

	validates :name, :address, presence: true, uniqueness: true
	validates :single_bedroom_price, :double_bedroom_price, :suite_room_price, :dormitory_room_price, presence: true

	has_attached_file :picture, styles: {large: "500x500>", medium: "300x300>", thumb: "150x150#"}
	validates_attachment_content_type :picture, content_type: %r{\Aimage\/.*\z}
	validates_attachment_presence :picture

end