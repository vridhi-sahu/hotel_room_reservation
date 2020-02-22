class City < ApplicationRecord
  has_many :hotels

	validates :name, presence: true, uniqueness: true
end
