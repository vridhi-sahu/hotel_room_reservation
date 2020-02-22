class RemoveCityFromHotels < ActiveRecord::Migration[5.2]
  def change
    remove_column :hotels, :city, :string
    add_reference :hotels, :city, index: true
    add_foreign_key :hotels, :cities
  end
end
