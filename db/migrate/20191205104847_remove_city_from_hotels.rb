class RemoveCityFromHotels < ActiveRecord::Migration[5.2]
  def change
    add_reference :hotels, :city, index: true
  end
end
