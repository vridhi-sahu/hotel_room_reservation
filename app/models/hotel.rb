class Hotel < ApplicationRecord
	has_many :bookings
	belongs_to :city
	validates_associated :city

	geocoded_by :address
	after_validation :geocode

	validates :name, :address, presence: true, uniqueness: true
	validates :single_bedroom_price, :double_bedroom_price, :suite_room_price, :dormitory_room_price,
					  :single_bedroom_num, :double_bedroom_num, :suite_room_num, :dormitory_room_num,
					  presence: true

	has_attached_file :picture, styles: {large: "500x500>", medium: "300x300>", thumb: "150x150#"}
	validates_attachment_content_type :picture, content_type: %r{\Aimage\/.*\z}
	validates_attachment_presence :picture

	# IMAGE_TYPES = %w[image/gif image/jpeg image/pjpeg image/x-png image/png].freeze

	# has_one_attached :image

	# validates :image, content_type: { in: IMAGE_TYPES, message: 'invalid format' }, requisites: false

	# def image_path
	#   image.attached? ? image : 'account-add-photo.svg'
	# end

end