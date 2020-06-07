class City < ApplicationRecord
  has_many :hotels

	validates :name, presence: true, uniqueness: { case_sensitive: false }
end
